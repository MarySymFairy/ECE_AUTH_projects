#include <RF22.h>
#include <RF22Router.h>
#include <SPI.h>
#include <MFRC522.h>

// Address definition for RF card
#define MY_ADDRESS 23
#define DESTINATION_ADDRESS 18

// Pin definitions
#define SS_PIN 8
#define RST_PIN 3
const int trigPin = 5;
const int echoPin = 6;
const int buzzerPin = 9;

// Initialize modules
MFRC522 rfid(SS_PIN, RST_PIN); // Initialize RFID
RF22Router rf22(MY_ADDRESS); // Intitialize RF card

// Variable definitions
String idString = "E"; // Initialize an empty string to store ID
int sensorVal = 10;
long randNumber;
boolean successful_packet = false;
int max_delay=3000;
const int distanceParked = 10;
float duration, distance;
int isParked;
bool buzzerCnt = false; // Initialize buzzer count to false
bool cardScanned = false;

void setup() {
  // Set pin modes
  pinMode(trigPin, OUTPUT);  
	pinMode(echoPin, INPUT);
  pinMode(buzzerPin, OUTPUT);

  // Initialize serial at 9600 baud
  Serial.begin(9600);
  Serial.println("Setup complete, starting loop...");

  // Initialize RF card
  if (!rf22.init())
    Serial.println("RF22 init failed");
  // Defaults after init are 434.0MHz, 0.05MHz AFC pull-in, modulation FSK_Rb2_4Fd36
  if (!rf22.setFrequency(431.0))
    Serial.println("setFrequency Fail");
  rf22.setTxPower(RF22_TXPOW_20DBM);
  rf22.setModemConfig(RF22::GFSK_Rb125Fd125);
  // Manually define the routes for this network
  rf22.addRouteTo(DESTINATION_ADDRESS, DESTINATION_ADDRESS);

  // Initialize RFID card
  SPI.begin(); // Init SPI bus
  rfid.PCD_Init(); // Init MFRC522 
}


void loop() {

  //Distance Sensor & Buzzer
  digitalWrite(trigPin, LOW); // Clears the trigPin condition
  delayMicroseconds(2); // Sets a 2 microsecond delay to ensure clean HIGH signal
  
  digitalWrite(trigPin, HIGH); // Sets the trigPin HIGH (ACTIVE) for 10 microseconds
  delayMicroseconds(10); // Delay enough for the sensor to emit the ultrasonic pulse
  digitalWrite(trigPin, LOW); // Stops emitting the ultrasonic burst
  
  duration = pulseIn(echoPin, HIGH); // Reads the echoPin, returns the sound wave travel time in microseconds
  
  if(duration == 0){
    Serial.println("No echo received");
  } else {
    distance = (duration * 0.0343) / 2; // Calculating the distance

    if (distance < 7){ // Car is fully parked
      if (buzzerCnt == false){ // Beep only once
        digitalWrite(buzzerPin, HIGH);
        delay(1000);
        digitalWrite(buzzerPin, LOW);
        buzzerCnt = true;
      }
      Serial.println("PARKED CAR (distance < 7cm)"); // Adds "cm" and moves to the next line
      isParked = 1;
      
      // If parked, read rfid
      if(!cardScanned){
        idString = readRFID();
        cardScanned = true;
      }
    }
    else if (distance < distanceParked){ // Car is half parked
      Serial.println("PARKED CAR (distance < 10cm)"); // Adds "cm" and moves to the next line
      isParked = 1;
      buzzerCnt = false;
      idString = "E"; // Make id string empty ready for new card
      cardScanned = false;
      
      for (int i=0; i<3; i++){ // Beep slow
        digitalWrite(buzzerPin, HIGH);
        delay(50);
        digitalWrite(buzzerPin, LOW);
      }
    }    
    else{ // Spot is empty
      digitalWrite(buzzerPin, LOW);
      Serial.print("Distance: ");
      Serial.print(distance); // Prints the distance on the Serial Monitor
      Serial.println(" cm"); // Adds "cm" and moves to the next line
      isParked = 0;
      buzzerCnt = false;
      idString = "E"; // Make id string empty ready for new card
      cardScanned = false;
    }
  }

  // Print my data to serial
  Serial.println();
  Serial.print("Sensor Distance: ");
  Serial.println(distance);
  Serial.print("Parked: ");
  Serial.println(isParked);
  Serial.print("Card scanned:");
  Serial.println(cardScanned);
 
  // Print ID
    Serial.print("ID:");
    for(int i=0; i<idString.length(); i++) {
      Serial.print(idString.charAt(i));
    }
    Serial.println();

  // Send data thru RF
  char data_send[idString.length() + 1];
  idString.toCharArray(data_send, idString.length() + 1 );

  successful_packet = false;
  while (!successful_packet)
  {
    if (rf22.sendtoWait(data_send, sizeof(data_send), DESTINATION_ADDRESS) != RF22_ROUTER_ERROR_NONE)
    {
      Serial.println("sendtoWait failed");
      randNumber=random(200,max_delay);
      Serial.println(randNumber);
      delay(randNumber);
    }
    else
    {
      successful_packet = true;
      // Serial.println("sendtoWait Succesful");
    }
  }

  // Close RFID 
  rfid.PICC_HaltA(); // Halt PICC
  rfid.PCD_StopCrypto1(); // Stop encryption on PCD

  delay(200); // Delay a second before the next measurement to avoid signal interference
}

String readRFID(){
  Serial.println("Waiting for card...");
  String idString = "";
  
  while (idString == ""){
    // delay(1000);
    Serial.println("Scanning...");

    if ( ! rfid.PICC_IsNewCardPresent()) {
      Serial.println("No card!");
      continue;
    }

    // Select one of the cards
    if ( ! rfid.PICC_ReadCardSerial()) {
      Serial.println("Cannot read card!");
      continue;
    }

    for (byte i = 0; i < 4; i++) {
      idString += String(rfid.uid.uidByte[i] < 0x10 ? " 0" : " ");
      idString += String(rfid.uid.uidByte[i], HEX);

    }

    break;
  }

  return idString;
}





#include <Servo.h>
#include <RF22.h>
#include <RF22Router.h>

#define MY_ADDRESS 18
#define NODE_ADDRESS_1 23
#define NODE_ADDRESS_2 13
#define NODE_ADDRESS_3 14
RF22Router rf22(MY_ADDRESS);


const int photoRes0Pin = A0; // Photoresistor before thr bar at Arduino analog pin A0
const int photoRes1Pin = A1; // Photoresistor after the bar at Arduino analog pin A1
Servo servoMotor; // Define Servo
int value0;				  // Store value from photoresistor before the bar (0-1023)
int value1;				  // Store value from photoresistor after the bar(0-1023)

void setup(){
  servoMotor.attach(9); // Attach servo motor to pin 9
  pinMode(photoRes0Pin, INPUT);// A0 pin as an input
  pinMode(photoRes1Pin, INPUT);// A1 pin as an input
  Serial.begin(9600);
  
  servoMotor.write(0); // Initialise the gate closed

  if (!rf22.init())
    Serial.println("RF22 init failed");
  // Defaults after init are 434.0MHz, 0.05MHz AFC pull-in, modulation FSK_Rb2_4Fd36
  if (!rf22.setFrequency(431.0))
    Serial.println("setFrequency Fail");
  rf22.setTxPower(RF22_TXPOW_20DBM);
  //1,2,5,8,11,14,17,20 DBM
  rf22.setModemConfig(RF22::GFSK_Rb125Fd125);
  //modulation

  // Manually define the routes for this network
  rf22.addRouteTo(NODE_ADDRESS_1, NODE_ADDRESS_1);
  rf22.addRouteTo(NODE_ADDRESS_2, NODE_ADDRESS_2);
  rf22.addRouteTo(NODE_ADDRESS_3, NODE_ADDRESS_3);
}

void loop(){
  value0 = analogRead(photoRes0Pin);
  value1 = analogRead(photoRes1Pin);
  
  if (value0 < 25){
    servoMotor.write(90); // If first photoresistor dark, open gate
  }
  if (value1 < 25){
	delay(1500); // Delay for 1.5 sec before closing
    servoMotor.write(0); // If second photoresistor dark, close gate.
  }

  uint8_t buf[RF22_ROUTER_MAX_MESSAGE_LEN];
  char incoming[RF22_ROUTER_MAX_MESSAGE_LEN];
  memset(buf, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
  memset(incoming, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
  uint8_t len = sizeof(buf);
  uint8_t from; 

  if (rf22.recvfromAck(buf, &len, &from))
  {
    buf[RF22_ROUTER_MAX_MESSAGE_LEN - 1] = '\0';
    memcpy(incoming, buf, RF22_ROUTER_MAX_MESSAGE_LEN);
    // Serial.print("got request from : ");
    // Serial.println(from, DEC);
    // Serial.print((char*) buf);
  }

  if(len != 45){
    // Dummy print needed for python
    Serial.print("S1:E,S2:E,S3:");
    Serial.print(incoming);
    Serial.println(",S4:E,end");
  }

  // Delay loop
  delay(500);
}
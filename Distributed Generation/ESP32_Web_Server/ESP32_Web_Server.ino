/*********
  Rui Santos & Sara Santos - Random Nerd Tutorials
  Complete project details at https://RandomNerdTutorials.com/esp32-web-server-sent-events-sse/
  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files.  
  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*********/
// Libraries for the web server
#include <WiFi.h>
#include <AsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include <LittleFS.h>


//Libraries for sensors
#include <DHT.h>
#include <Wire.h>
#include <SPI.h>
#include <Adafruit_BMP280.h>


//Sensor Pins 
#define DHTPIN 4     // Digital pin connected to the DHT sensor
#define DHTTYPE DHT22   // DHT 22  (AM2302), AM2321

#define UVPIN 34 // Analog pin for UV sensor -> GPIO34 (or another ADC pin)

// BMP280 uses I2C protocol & default GPIO21 and 22 for SDA SCL

// Replace with your network credentials
const char* ssid = "putyourSSIDhere";
const char* password = "putyourPASSWORDhere";

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

// Create an Event Source on /events
AsyncEventSource events("/events");

// Timer variables
unsigned long lastTime = 0;  
unsigned long timerDelay = 5000; //every 5 sec (5.000 millisec)


// Create sensor objects
DHT dht(DHTPIN, DHTTYPE); //DHT22
Adafruit_BMP280 bmp; // BMP280 with I2C

// Variables for sensor values
float temperature;
float humidity;
int UV = 0; //uvIndex
float pressure = 0.0;


void getDHTReadings(){
  float temp = dht.readTemperature();
  float hum = dht.readHumidity();
  if (!isnan(temp)) temperature = temp;
  if (!isnan(hum)) humidity = hum;
}

void getUVReading(){
  long sum = 0;
  // Sample sensor 1024 times with 2ms delay
  for (int i = 0; i < 1024; i++) {
    sum += analogRead(UVPIN);
    delay(2);
  }
  // Average ADC value
  int avgSensorValue = sum >> 10; // equivalent to sum / 1024

  float vout_actual = avgSensorValue * (3300.0 / 4095.0); 
  // ESP32 ADC range: 12bits -> 0–4095, Reference: 3300 mV

  // Estimate what the output would be if powered from 5V
  // Since ADC value is normalized, we simply scale up
  float vout_5V = (vout_actual / 3300.0) * 5000.0;

  // Adjusted UV Index thresholds scaled from 5V to 3.3V
  // new_threshold = old_threshold * 3.3 / 5.0;   (from the values of UV sensor in datasheet)
  if (vout_5V < 50) UV = 0;
  else if (vout_5V < 227) UV = 1;
  else if (vout_5V < 318) UV = 2;
  else if (vout_5V < 408) UV = 3;
  else if (vout_5V < 503) UV = 4;
  else if (vout_5V < 606) UV = 5;
  else if (vout_5V < 696) UV = 6;
  else if (vout_5V < 795) UV = 7;
  else if (vout_5V < 881) UV = 8;
  else if (vout_5V < 976) UV = 9;
  else if (vout_5V < 1079) UV = 10;
  else UV = 11;

  Serial.printf("UV Voltage of 3.3V = %.2f mV\n", vout_actual);

  Serial.printf("UV Voltage 5V = %.2f mV\n", vout_5V);
}

void getBMPReading(){
  float pres = bmp.readPressure();
  if (!isnan(pres)) {
    pressure = pres / 100.0; // convert Pa to hPa
  }
}

//Init BMP280
void initBMP() {
  // Using ESP32's default I2C pins for BMP280 SDA and SCL
  if (!bmp.begin(0x76)) { // use 0x76 or 0x77 depending on your module
    Serial.println(F("Could not find BMP280 sensor at 0x76!"));
    while (1); // Halt if sensor not found
  }
  // Optional: set oversampling and filtering
  bmp.setSampling(
    Adafruit_BMP280::MODE_NORMAL,
    Adafruit_BMP280::SAMPLING_X2,
    Adafruit_BMP280::SAMPLING_X16,
    Adafruit_BMP280::FILTER_X16,
    Adafruit_BMP280::STANDBY_MS_500
  );
}

// Initialize WiFi
void initWiFi() {
    WiFi.mode(WIFI_STA);
    WiFi.begin(ssid, password);
    Serial.print("Connecting to WiFi ..");
    while (WiFi.status() != WL_CONNECTED) {
        Serial.print('.');
        delay(1000);
    }
    Serial.println(WiFi.localIP());
}

// For HTML template
String processor(const String& var){
  //get Sensor Readings
  getDHTReadings();
  getUVReading();
  getBMPReading();

  //Serial.println(var);
  if(var == "TEMPERATURE"){
    return String(temperature);
  }
  else if(var == "HUMIDITY"){
    return String(humidity);
  }
  else if(var == "PRESSURE"){
    return String(pressure);
  }
  else if (var == "UV") {
    return String(UV);
  }
  return String();
}



void setup() {
  Serial.begin(115200);

  initWiFi();

  //SENSORS
  dht.begin();
  initBMP();
  analogReadResolution(12); // ESP32 uses 12-bit ADC: 0-4095

  // Init LittleFS
  if (!LittleFS.begin()) {
    Serial.println("LittleFS mount failed");
    return;
  }

  // Serve static files
  server.serveStatic("/", LittleFS, "/").setDefaultFile("index.html");

  // SSE endpoint
  events.onConnect([](AsyncEventSourceClient *client){
    Serial.println("Client connected to SSE");
    if (client->lastId()) {
      Serial.printf("Last message ID client received: %u\n", client->lastId());
    }
    client->send("hello!", NULL, millis(), 10000);
  });
  server.addHandler(&events);

  // Start the server
  server.begin();
}


void loop() {
  if ((millis() - lastTime) > timerDelay) {
    getDHTReadings();
    getUVReading();
    getBMPReading();

    Serial.printf("UV Index = %d\n", UV);
    Serial.printf("Temperature = %.2f ºC \n", temperature);
    Serial.printf("Humidity = %.2f \n", humidity);
    Serial.printf("Pressure = %.2f hPa \n", pressure);

    Serial.println();

    // Send Events to the Web Client with the Sensor Readings
    events.send("ping",NULL,millis());
    events.send(String(temperature).c_str(),"temperature",millis());
    events.send(String(humidity).c_str(),"humidity",millis());
    events.send(String(pressure).c_str(),"pressure",millis());
    events.send(String(UV).c_str(), "UV", millis());


    lastTime = millis();
  }
}
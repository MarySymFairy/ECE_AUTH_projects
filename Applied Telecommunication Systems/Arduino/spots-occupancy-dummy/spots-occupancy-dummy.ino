void setup() {
  Serial.begin(9600);
}

void loop() {
  int spot1, spot2, spot3, spot4;
  spot1 = random(0,8);
  spot2 = random(0,8);
  spot3 = random(0,8);
  spot4 = random(0,8);

  Serial.print("S1:");
  if(spot1){
    Serial.print(spot1);
  }
  else{
    Serial.print("E");
  }

  Serial.print(",S2:");
  if(spot2){ 
    Serial.print(spot2);
  }
  else{ 
    Serial.print("E");
  }

  Serial.print(",S3:");
  if(spot3) 
    Serial.print(spot3);
  else
    Serial.print("E");

  Serial.print(",S4:");
  if(spot4) 
    Serial.print(spot4);
  else 
    Serial.print("E");

  Serial.println(",end:");

  delay(2500);
}

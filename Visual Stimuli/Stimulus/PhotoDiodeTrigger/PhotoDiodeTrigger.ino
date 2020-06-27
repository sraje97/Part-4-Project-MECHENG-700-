
int led = 13;
int gtec = 8;


 void setup() {
  pinMode(led, OUTPUT); 
  pinMode(gtec, OUTPUT);
  int digitalwrite(led,LOW);
  Serial.begin(9600);
}

 void loop() {
  int sensorValue = 0;
  sensorValue = analogRead(A0);
  Serial.println(sensorValue);
  if (sensorValue>600)
  {
    digitalWrite(led,HIGH);
    digitalWrite(gtec,HIGH);
//    Serial.println("trigger");
  } 
  else {
    digitalWrite(led,LOW);
    digitalWrite(gtec,LOW);
  }

}

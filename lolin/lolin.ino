#include "SoftwareSerial.h";

SoftwareSerial mySerial(7, 8);

void setup() {
  mySerial.begin(115200);
  Serial.begin(115200);
}

void loop() {
  mySerial.println("This is a top secret message");
  delay(1000);
}
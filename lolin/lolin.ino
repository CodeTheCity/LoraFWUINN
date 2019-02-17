#include "SoftwareSerial.h"

SoftwareSerial mySerial(16, 0);

void setup() {
  mySerial.begin(9600);
  pinMode(2, OUTPUT);
}

void sendMessageToLoRa(const char string[]) {
  mySerial.write(string);
  mySerial.write("\004");
}

void loop() {
  digitalWrite(2, HIGH);
  sendMessageToLoRa("This is a top secret message");
  delay(1000);
  digitalWrite(2, LOW);
  delay(1000);
}

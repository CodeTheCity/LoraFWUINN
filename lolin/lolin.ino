void setup() {
  Serial.begin(9600);
  pinMode(2, OUTPUT);
}

void loop() {
  digitalWrite(2, HIGH);
  Serial.println("This is a top secret message");
  delay(1000);
  digitalWrite(2, LOW);
  delay(1000);
}

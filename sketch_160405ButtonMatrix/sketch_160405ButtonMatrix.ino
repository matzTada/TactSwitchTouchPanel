#define WHOAMI 0

unsigned long pastMillis = millis();

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  for (int i = 2; i < 2 + 16; i++) {
    pinMode(i, INPUT_PULLUP);
  }

}

void loop() {
// Serial.println(millis() - pastMillis);
// pastMillis = millis();
  // put your main code here, to run repeatedly:
  String str = "";
  str += (String)WHOAMI;
  str += ",";
  for (int i = 2; i < 2 + 16; i++) {
    str += String(digitalRead(i));
    str += ",";
  }
  str += "\n";
  Serial.print(str);
}

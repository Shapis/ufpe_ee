#include <EEPROM.h>

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_BUILTIN, OUTPUT);
  // EEPROM.write(0,0);
  Serial.begin(9600);
}

int contador = 0;

// the loop function runs over and over again forever
void loop() {
  contador++;
  EEPROM.write(0,EEPROM.read(0)+1);

  
  digitalWrite(LED_BUILTIN, EEPROM.read(0) & 1); 


  Serial.println(EEPROM.read(0)); 
  // if (EE
  // digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  // delay(1000);                       // wait for a second
  // digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delay(100);                       // wait for a second
}

#include <Arduino.h>

//**********************************************************************************
/*
 * Filename    : MQ3
 * Description : Read the basic usage of Digital, ADC，DAC and Voltage
 * Auther      : http//www.keyestudio.com
 */
// MQ_3 two pins 13, 34, respectively
#define PIN_ANALOG_IN 34
int digitalPin = 13;

// The following two variables hold the digital signal and adc values respectively
int analogVal = 0;
int adcVal = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(digitalPin, INPUT); // Digital pin 13 is set to input mode
}

// In loop()，the digitalRead()function is used to obtain the digital value,
// the analogRead() function is used to obtain the ADC value.
// and then the map() function is used to convert the value into an 8-bit precision DAC value.
// The input and output voltage are calculated according to the previous formula,
// and the information is finally printed out.
void loop()
{
  int digitalVal = digitalRead(digitalPin); // Read digital signal;
  int adcVal = analogRead(PIN_ANALOG_IN);
  int dacVal = map(adcVal, 0, 4095, 0, 255);
  double voltage =adcVal / 4095.0 * 3.3;
  Serial.printf("digitalVal: %d, \t ADC Val: %d, \t DAC Val: %d, \t Voltage: %.2fV\n", digitalVal, adcVal, dacVal, voltage);
  if (digitalVal == 1)
  {
    Serial.println("  Normal");
  }
  else
  {
    Serial.println("  Exceeding");
  }
  delay(100); // Delay time 100 ms
}
//**********************************************************************************

// #define LED_BUILTIN 2 // GPIO2 is usually the built-in LED on ESP32

// void setup()
// {
//   pinMode(LED_BUILTIN, OUTPUT);
//   Serial.begin(9600); // Start Serial at 115200 baud
//   while (!Serial)
//     ; // Wait for Serial to connect (not always necessary on ESP32)
//   Serial.println("ESP32 is alive!");
// }

// void loop()
// {
//   // Turn the LED on
//   digitalWrite(LED_BUILTIN, HIGH);
//   delay(1000); // Wait for 1 second

//   // Turn the LED off
//   digitalWrite(LED_BUILTIN, LOW);
//   delay(1000); // Wait for 1 second
//   Serial.println("Still running...");
//   delay(1000); // Wait 1 second
// }
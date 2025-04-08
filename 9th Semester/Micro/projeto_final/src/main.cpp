#include <Arduino.h>
#include <WiFi.h>
#include <WiFiClientSecure.h>
#include "soc/soc.h"
#include "soc/rtc_cntl_reg.h"
#include "esp_camera.h"
#include <UniversalTelegramBot.h>
#include <ArduinoJson.h>

const char *ssid = "VIVO-102 2.4 GHz";
const char *password = "semfio23";

// Initialize Telegram BOT
String BOTtoken = "8036201674:AAGkCYeghu842uG-X_wzfkckQti13OTQjNk"; // your Bot Token (Get from Botfather)

// Use @myidbot to find out the chat ID of an individual or a group
// Also note that you need to click "start" on a bot before it can
// message you
String CHAT_ID = "7823442679";

WiFiClientSecure clientTCP;
UniversalTelegramBot bot(BOTtoken, clientTCP);

// Checks for new messages every 1 second.
int botRequestDelay = 1000;
unsigned long lastTimeBotRan;

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

  // Connect to Wi-Fi
  WiFi.mode(WIFI_STA);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  clientTCP.setCACert(TELEGRAM_CERTIFICATE_ROOT); // Add root certificate for api.telegram.org
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());
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
  double voltage = adcVal / 4095.0 * 3.3;
  Serial.printf("digitalVal: %d, \t ADC Val: %d, \t DAC Val: %d, \t Voltage: %.2fV\n", digitalVal, adcVal, dacVal, voltage);
  if (digitalVal == 1)
  {
    Serial.println("  Normal");
    bot.sendMessage(CHAT_ID, "Nivel Abaixo do Limite", "");
  }
  else
  {
    Serial.println("  Exceeding");
    bot.sendMessage(CHAT_ID, "Nivel Acima do Limite", "");
  }
  delay(1000); // Delay time 1000 ms
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
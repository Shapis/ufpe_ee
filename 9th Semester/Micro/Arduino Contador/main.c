// C++ code
//
#include "Adafruit_LEDBackpack.h"

Adafruit_7segment led_display1 = Adafruit_7segment();

char *timer = "0000";

int s_unidade = 0;
int s_dezena = 0;
int m_unidade = 0;
int m_dezena = 0;

void setup()
{
    Serial.begin(9600);
    TCCR1A = 0;             // Clear Timer/Counter1 Control Register A
    TCCR1B = 0;             // Clear Timer/Counter1 Control Register B
    TCNT1 = 0;              // Reset Timer/Counter1
    OCR1A = 0x3D09;         // Set Output Compare Register A
    TCCR1B = (1 << WGM12) | // Configure Timer1 in CTC mode
             (1 << CS10) |  // Set prescaler to 1024
             (1 << CS12);
    TIMSK1 = (1 << TOIE1); // Enable Timer/Counter1 Overflow Interrupt

    led_display1.begin(112);
    led_display1.println(timer);
    led_display1.writeDisplay();
}

ISR(TIMER1_OVF_vect)
{
    s_unidade++;
}

void loop()
{
    if (s_unidade > 9)
    {
        s_dezena++;
        s_unidade = 0;
    }
    else if (s_dezena > 5)
    {
        s_dezena = 0;
        m_unidade++;
    }
    else if (m_unidade > 9)
    {
        s_dezena = 0;
        m_dezena++;
    }
    else if (m_dezena > 5)
    {
        m_dezena = 0;
    }

    led_display1.writeDigitNum(4, s_unidade);
    led_display1.writeDigitNum(3, s_dezena);
    led_display1.writeDigitNum(1, m_unidade);
    led_display1.writeDigitNum(0, m_dezena);
    led_display1.writeDisplay();
    delay(50);
}
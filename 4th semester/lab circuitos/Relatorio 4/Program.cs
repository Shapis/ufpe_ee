// See https://aka.ms/new-console-template for more information

float r1;
float r2;
const float vcc = 10f;
float vth;

List<float> values = new List<float> { 220, 470, 1000, 3300, 6800 };

for (int i = 0; i < values.Count; i++)
{
    for (int j = 0; j < values.Count; j++)
    {
        r1 = values[i];
        r2 = values[j];
        vth = ((r2) / (r1 + r2)) * vcc;

        Console.WriteLine($"Para R1 = {r1} e R2 = {r2} temos Vth = {vth:0.00}");
    }
}

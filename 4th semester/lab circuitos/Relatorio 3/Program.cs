// See https://aka.ms/new-console-template for more information

const float r1 = 100000;
const float r2 = 47000;
const float r3 = 220000;

List<float> values = new List<float> { -1.2f, -0.6f, 0, 0.6f, 1.2f };

for (int i = 0; i < values.Count; i++)
{
    for (int j = 0; j < values.Count; j++)
    {
        float v1 = values[i];
        float v2 = values[j];
        float v0 = -(((r1 * r3 * v2) + (r2 * r3 * v1)) / (r1 * r2));

        Console.WriteLine($"Para v1 = {v1} e v2 = {v2} temos v0 = {v0:0.00}");
    }
}

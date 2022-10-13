using System.Text;

class Noise
{
    Random rng = new Random();

    public string NoiseItUp(string data, float p)
    {
        for (int i = 0; i < data.Length; i++)
        {
            if (rng.NextDouble() < p)
            {
                StringBuilder sb = new StringBuilder(data);
                sb[i] = data[i] == '0' ? '1' : '0';
                data = sb.ToString();
            }
        }
        return data;
    }
}

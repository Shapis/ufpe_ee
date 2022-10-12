using System.Text;

class Noise
{
    Random rng = new Random();

    public void NoiseRepetition(RepetitionCode repetitionCode, float p)
    {
        foreach (var item in repetitionCode.RepetitionBinaryData)
        {
            if (rng.NextDouble() <= p)
            {
                var sb = new StringBuilder(repetitionCode.RepetitionBinaryData);
                sb.Replace(
                    item,
                    item == '0' ? '1' : '0',
                    rng.Next(0, repetitionCode.RepetitionBinaryData.Length),
                    1
                );
                repetitionCode.RepetitionBinaryData = sb.ToString();
            }
        }
    }

    public void NoiseHamming(HammingCode hammingCode, float p)
    {
        foreach (var block in hammingCode.HammingBlocks)
        {
            foreach (var item in block)
            {
                Random a = new();
                // _hammingCode.WriteHammingBlockAsMatrix(_hammingCode.HammingBlocks[0]);
            }
        }
    }
}

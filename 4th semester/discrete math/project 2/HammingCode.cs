class HammingCode
{
    public List<int[]> HammingBlocks { get; } = new();

    private int _trim = 0;

    private List<int> _parityBits = new();

    // Constructor
    public HammingCode(string binaryData, int blockLength)
    {
        // Parity bit positions
        for (int i = 0; i < blockLength; i++)
        {
            if (IsPowerOfTwo(i))
            {
                _parityBits.Add(i);
            }
        }

        var effectiveLength = blockLength - _parityBits.Count - 1;
        _trim = (effectiveLength - binaryData.Length % effectiveLength);
        // Console.WriteLine(LastBlockLength);

        // Console.WriteLine("Parity bits: " + string.Join(", ", parityBits));

        int[] _hammingBlock = new int[blockLength];

        int position = 1;
        bool nonEmptyBlock = false;

        for (int i = 0; i < binaryData.Length; i++)
        {
            while (_parityBits.Contains(position))
            {
                position++;
            }

            if (position < blockLength)
            {
                nonEmptyBlock = true;
                _hammingBlock[position] = int.Parse(binaryData[i].ToString());
                position++;
            }
            else
            {
                i--;
                HammingBlocks.Add(_hammingBlock);
                _hammingBlock = new int[blockLength];
                position = 1;
                nonEmptyBlock = false;
            }
        }
        if (nonEmptyBlock)
        {
            HammingBlocks.Add(_hammingBlock);
        }

        SetParityBits(_parityBits);

        // Sets parity bits
        void SetParityBits(List<int> parityBits)
        {
            foreach (var block in HammingBlocks)
            {
                List<int> paritySum = new();
                for (int i = 1; i < block.Length; i++)
                {
                    if (parityBits.Contains(i))
                    {
                        continue;
                    }
                    else
                    {
                        if (block[i] == 1)
                        {
                            paritySum.Add(i);
                        }
                    }
                }
                List<string> binaryParity = new();
                foreach (var item in paritySum)
                {
                    var binaryPosition = Convert.ToString(item, 2).PadLeft(parityBits.Count, '0');
                    binaryParity.Add(binaryPosition);
                }

                for (int i = 0; i < parityBits.Count; i++)
                {
                    int sum = 0;
                    foreach (var item in binaryParity)
                    {
                        sum += int.Parse(item[i].ToString());
                    }
                    block[parityBits[parityBits.Count - i - 1]] = sum % 2;
                }
            }
        }

        bool IsPowerOfTwo(int n)
        {
            if (n == 0)
                return false;

            while (n != 1)
            {
                if (n % 2 != 0)
                    return false;

                n = n / 2;
            }
            return true;
        }
    }

    // Detects which power of two a number is
    private int GetPowerOfTwo(int n)
    {
        int power = 0;
        while (n != 1)
        {
            n = n / 2;
            power++;
        }
        return power;
    }

    // Write Hamming Block as Matrix
    public void WriteHammingBlockAsMatrix(int[] block)
    {
        int height,
            width;
        if (GetPowerOfTwo(block.Length) % 2 == 0)
        {
            height = width = (int)Math.Sqrt((double)block.Length);
        }
        else
        {
            width = (int)Math.Sqrt((double)block.Length * 2);
            height = width / 2;
        }
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                Console.Write(block[j + (i * width)] + "\t");
            }
            Console.WriteLine();
        }
    }

    // Decode to binary
    public string DecodeToBinary()
    {
        string binaryData = "";
        foreach (var block in HammingBlocks)
        {
            for (int i = 1; i < block.Length; i++)
            {
                if (_parityBits.Contains(i))
                {
                    continue;
                }
                else
                {
                    binaryData += block[i];
                }
            }
        }
        binaryData = binaryData.Substring(0, binaryData.Length - _trim);
        return binaryData;
    }
}

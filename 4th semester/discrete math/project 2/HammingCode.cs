using System.Text;

class HammingCode
{
    private List<int[]> _hammingBlocks = new();

    public string BinaryData = "";

    private int _blockLength = 0;

    private int _trim = 0;

    private List<int> _parityBits = new();

    // Constructor
    public HammingCode(string binaryData, int blockLength)
    {
        _blockLength = blockLength;
        // Parity bit positions
        for (int i = 0; i < blockLength; i++)
        {
            if (IsPowerOfTwo(i))
            {
                _parityBits.Add(i);
            }
        }
        Console.WriteLine(_parityBits.Count);
        var effectiveLength = blockLength - _parityBits.Count - 1;
        _trim = (effectiveLength - binaryData.Length % effectiveLength);

        if (blockLength == 8)
        {
            _trim = 0;
        }
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
                _hammingBlocks.Add(_hammingBlock);
                _hammingBlock = new int[blockLength];
                position = 1;
                nonEmptyBlock = false;
            }
        }
        if (nonEmptyBlock)
        {
            _hammingBlocks.Add(_hammingBlock);
        }

        SetParityBits(_parityBits);

        // Sets parity bits
        void SetParityBits(List<int> parityBits)
        {
            foreach (var block in _hammingBlocks)
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
        BinaryData = HammingBlocksToString();

        // HammingBlocks to string
        string HammingBlocksToString()
        {
            string result = "";
            foreach (var block in _hammingBlocks)
            {
                foreach (var item in block)
                {
                    result += item;
                }
            }
            return result;
        }
    }

    // Write Hamming Block as Matrix
    public void WriteHammingBlockAsMatrix(int blockIndex)
    {
        int height,
            width;
        if (GetPowerOfTwo(_hammingBlocks[blockIndex].Length) % 2 == 0)
        {
            height = width = (int)Math.Sqrt((double)_hammingBlocks[blockIndex].Length);
        }
        else
        {
            width = (int)Math.Sqrt((double)_hammingBlocks[blockIndex].Length * 2);
            height = width / 2;
        }
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                Console.Write(_hammingBlocks[blockIndex][j + (i * width)] + "\t");
            }
            Console.WriteLine();
        }

        // Detects which power of two a number is
        int GetPowerOfTwo(int n)
        {
            int power = 0;
            while (n != 1)
            {
                n = n / 2;
                power++;
            }
            return power;
        }
    }

    // Decode to binary
    public string DecodeToBinary()
    {
        StringToHammingBlocks(BinaryData);
        FixErrors();
        string binaryData = "";
        foreach (var block in _hammingBlocks)
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

        void FixErrors()
        {
            foreach (var block in _hammingBlocks)
            {
                List<string> binaryParity = new();
                for (int i = 1; i < block.Length; i++)
                {
                    if (block[i] == 1)
                    {
                        var binaryPosition = Convert.ToString(i, 2).PadLeft(_parityBits.Count, '0');
                        binaryParity.Add(binaryPosition);
                    }
                }

                int[] parityBits = new int[_parityBits.Count];
                for (int i = 0; i < _parityBits.Count; i++)
                {
                    int sum = 0;
                    foreach (var item in binaryParity)
                    {
                        sum += int.Parse(item[i].ToString());
                    }
                    parityBits[i] = sum % 2;
                }

                // Console.WriteLine("Parity bits: " + string.Join(", ", parityBits));

                int errorPosition = 0;
                for (int i = 0; i < parityBits.Length; i++)
                {
                    errorPosition += parityBits[i] * (int)Math.Pow(2, parityBits.Length - i - 1);
                }

                if (errorPosition != 0)
                {
                    block[errorPosition] = block[errorPosition] == 0 ? 1 : 0;
                }
                break;
            }
        }

        // Clears the currently held hamming blocks and returns a new hammingblocks list from a string
        void StringToHammingBlocks(string data)
        {
            _hammingBlocks.Clear();
            int[] hb = new int[_blockLength];
            for (int i = 0; i < data.Length; i++)
            {
                hb[i % _blockLength] = int.Parse(data[i].ToString());
                if (i % _blockLength == _blockLength - 1)
                {
                    _hammingBlocks.Add(hb);
                    hb = new int[_blockLength];
                }
            }
        }
    }
}

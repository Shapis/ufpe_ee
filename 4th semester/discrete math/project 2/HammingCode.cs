class HammingCode
{
    public List<int[]> HammingBlocks { get; } = new();

    // Constructor
    public HammingCode(string binaryData, int blockLength)
    {
        int[] _hammingBlock = new int[blockLength];

        int position = 1;
        bool nonEmptyBlock = false;

        for (int i = 0; i < binaryData.Length; i++)
        {
            while (IsPowerOfTwo(position))
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
    }

    private bool IsPowerOfTwo(int n)
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

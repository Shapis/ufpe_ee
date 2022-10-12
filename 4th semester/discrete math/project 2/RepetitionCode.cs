class RepetitionCode
{
    public string RepetitionBinaryData = "";

    public RepetitionCode(string binaryData, int repetitionNumber)
    {
        foreach (var item in binaryData)
        {
            for (int i = 0; i < repetitionNumber; i++)
            {
                RepetitionBinaryData += item;
            }
        }
    }

    public string DecodeToBinary()
    {
        string decodedData = "";
        for (int i = 0; i < RepetitionBinaryData.Length; i += 5)
        {
            var block = RepetitionBinaryData.Substring(i, 5);
            var sum = 0;
            foreach (var item in block)
            {
                sum += item - '0';
            }
            if (sum >= 3)
            {
                decodedData += "1";
            }
            else
            {
                decodedData += "0";
            }
        }
        return decodedData;
    }
}

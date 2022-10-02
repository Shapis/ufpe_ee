class RepetitionCode
{
    private string _repetitionBinaryData = "";

    public RepetitionCode(string binaryData, int repetitionNumber)
    {
        foreach (var item in binaryData)
        {
            for (int i = 0; i < repetitionNumber; i++)
            {
                _repetitionBinaryData += item;
            }
        }
    }

    public string DecodeToBinary()
    {
        string decodedData = "";
        for (int i = 0; i < _repetitionBinaryData.Length; i += 5)
        {
            var block = _repetitionBinaryData.Substring(i, 5);
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

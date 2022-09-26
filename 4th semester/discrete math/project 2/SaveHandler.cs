class SaveHandler
{
    public static async Task WriteToFile(string[] strings, string fileName)
    {
        await File.WriteAllLinesAsync(fileName + ".txt", strings);
    }

    public static async Task<string[]> ReadFromFile(string fileName)
    {
        return await File.ReadAllLinesAsync(fileName + ".txt");
    }
}

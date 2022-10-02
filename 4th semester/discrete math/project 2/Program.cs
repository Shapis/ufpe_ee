using System.Numerics;

var codificador = new Codificador();

var textoCodificado = codificador.TextoParaBinario("abcd");

var HammingCode = new HammingCode(textoCodificado, 16);

Console.WriteLine(textoCodificado);

// Prints a list of Hamming Blocks
foreach (var block in HammingCode.HammingBlocks)
{
    foreach (var bit in block)
    {
        Console.Write(bit);
    }
    Console.WriteLine();
}
// 01100001011 00010011000 1101100100

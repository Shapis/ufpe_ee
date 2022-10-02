using System.Numerics;

var codificador = new Codificador();

var textoCodificado = codificador.TextoParaBinario("abcd");

var hammingCode = new HammingCode(textoCodificado, 16);

Console.WriteLine(textoCodificado);

// // Prints a list of Hamming Blocks
// foreach (var block in hammingCode.HammingBlocks)
// {
//     foreach (var bit in block)
//     {
//         Console.Write(bit);
//     }
//     Console.WriteLine();
// }

hammingCode.WriteHammingBlockAsMatrix(hammingCode.HammingBlocks[1]);

Console.WriteLine(hammingCode.DecodeToBinary());
//

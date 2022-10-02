using System.Numerics;

var codificador = new Codificador();

var textoCodificado = codificador.TextoParaBinario("abcd");

var hammingCode = new HammingCode(textoCodificado, 16);

Console.WriteLine(textoCodificado);

// hammingCode.WriteHammingBlockAsMatrix(hammingCode.HammingBlocks[1]);

// Console.WriteLine(hammingCode.DecodeToBinary());

// var textoDecodificado = codificador.BinarioParaTexto(hammingCode.DecodeToBinary());

// Console.WriteLine(textoDecodificado);

var repetitionCode = new RepetitionCode(textoCodificado, 5);

Console.WriteLine(repetitionCode.DecodeToBinary());

//

using System.Text;

var codificador = new Codificador();

var textoCodificado = codificador.TextoParaBinario("Ola como vai voce");

Console.WriteLine(textoCodificado);

var repetitionCode = new RepetitionCode(textoCodificado, 5);

var hammingCode = new HammingCode(textoCodificado, 16);

var noise = new Noise();
noise.NoiseRepetition(repetitionCode, 0.15f);
noise.NoiseHamming(hammingCode, 0.35f);

// replace char at index in repetition binary data
Console.WriteLine(repetitionCode.DecodeToBinary());

var textoDecodificado = codificador.BinarioParaTexto(repetitionCode.DecodeToBinary());

Console.WriteLine(textoDecodificado);

textoDecodificado = codificador.BinarioParaTexto(hammingCode.DecodeToBinary());
Console.WriteLine(textoDecodificado);



// hammingCode.WriteHammingBlockAsMatrix(hammingCode.HammingBlocks[1]);

// Console.WriteLine(repetitionCode.DecodeToBinary());

//

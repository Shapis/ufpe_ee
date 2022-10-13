using System.Numerics;
using System.Text;

// Probabilidade de erro em cada bit apos passar pela funcao NoiseItUp()
float p = 0f;

// Inicializa a lista de SNRdb com valores entre 3 e 10 em incrementos de 0.35, para obtermos 20 valores no total.
List<float> SNRdb = new List<float>();

// Inicializa a classe que vai rodar nossos testes.
TestRunner testRunner = new TestRunner();

for (int i = 0; i < 21; i++)
{
    SNRdb.Add(3 + i * 0.35f);
}

// Inicializa a lista de SNR, com valores obtidos a partir dos valores desejados de SNRdb
List<float> SNR = new List<float>();

for (int i = 0; i < SNRdb.Count; i++)
{
    SNR.Add((float)Math.Pow(10, SNRdb[i] / 10));
}

// Cria o codificador de texto, que vai passar as mensagems de binario para string e vice versa.
var codificador = new Codificador();

// Texto a ser codificado
const string textoParaCodificar =
    "Pra poesia que a gente nao vive, transformar o tedio em melodia.";

var textoCodificado = codificador.TextoParaBinario(textoParaCodificar);

// testRunner.TestarPorcentagemDeErroPorBitRepeticao(5, SNRdb, SNR, p, textoCodificado);

// testRunner.TestarPorcentagemDeErroPorBitHamming(7, 4, SNRdb, SNR, p, textoCodificado);

// testRunner.TestarPorcentagemDeErroPorBitSemCodigo(SNRdb, SNR, p, textoCodificado);


p = 0.01f;

// Cria o codigo de repeticao, com repeticao tamanho 5.
var repetitionCode = new RepetitionCode(textoCodificado, 5);

// Cria o codigo de hamming com tamanho (16-1) = 15
var hammingCode15 = new HammingCode(textoCodificado, 16);

// Cria o codigo de hamming com tamanho (8-1) = 7
var hammingCode7 = new HammingCode(textoCodificado, 8);

var noise = new Noise();

var textoCodificadoNoiseado = noise.NoiseItUp(textoCodificado, p);
repetitionCode.BinaryData = noise.NoiseItUp(repetitionCode.BinaryData, p);
hammingCode15.BinaryData = noise.NoiseItUp(hammingCode15.BinaryData, p);
hammingCode7.BinaryData = noise.NoiseItUp(hammingCode7.BinaryData, p);

// Imprime os resultados
Console.WriteLine("Resultado para o texto sem correcao de erros:");
Console.WriteLine(codificador.BinarioParaTexto(textoCodificadoNoiseado));
Console.WriteLine("Resultado do teste de repeticao R(5,1,3):");
Console.WriteLine(codificador.BinarioParaTexto(repetitionCode.DecodeToBinary()));
Console.WriteLine("Resultado do teste de hamming C(15,11,3):");
Console.WriteLine(codificador.BinarioParaTexto(hammingCode15.DecodeToBinary()));
Console.WriteLine("Resultado do teste de hamming C(11,7,3):");
Console.WriteLine(codificador.BinarioParaTexto(hammingCode7.DecodeToBinary()));

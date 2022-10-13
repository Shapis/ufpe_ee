using System.Text;

// Probabilidade de erro em cada bit apos passar pela funcao NoiseItUp()
float p = 0.01f;

// Inicializa a lista de SNRdb com valores entre 3 e 10 em incrementos de 0.35, para obtermos 20 valores no total.
List<float> SNRdb = new List<float>();

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

// Classe que gera erros no codigo com a probabiidade p de dar flip em cada bit.
var noise = new Noise();

// const string textoParaCodificar =
//     "Pra poesia que a gente nao vive, transformar o tedio em melodia.";
const string textoParaCodificar =
    "Pra poesia que a gente nao vive, transformar o tedio em melodia.";

var textoCodificado = codificador.TextoParaBinario(textoParaCodificar);

// Relacao mensagem/codigo, R = (k/n)
// float R = (1f / 5f);
// for (int i = 0; i < SNR.Count; i++)
// {
//     Console.WriteLine("SNRdb: " + SNRdb[i]);
//     // Cria a funcao erro que vai computar a probabilidade p de cada bit ser alterado.
//     p = (float)ErrorFunction.Erfc(Math.Sqrt(2 * R * SNR[i]));

//     int quantidadeDeErros = 0;
//     int quantidadeDeIteracoes = 1000;
//     // Console.WriteLine(p);
//     for (int j = 0; j < quantidadeDeIteracoes; j++)
//     {
//         var repetitionCode = new RepetitionCode(textoCodificado, 5);
//         repetitionCode.BinaryData = noise.NoiseItUp(repetitionCode.BinaryData, p);
//         if (codificador.BinarioParaTexto(repetitionCode.DecodeToBinary()) != textoParaCodificar)
//         {
//             quantidadeDeErros++;
//         }
//     }
//     //Console.WriteLine(p);
//     Console.WriteLine((float)quantidadeDeErros / (float)quantidadeDeIteracoes);
// }


// Cria o codigo de repeticao, com repeticao tamanho 5.
var repetitionCode = new RepetitionCode(textoCodificado, 5);

// Cria o codigo de hamming com tamanho (16-1) = 15
var hammingCode15 = new HammingCode(textoCodificado, 16);

// Cria o codigo de hamming com tamanho (8-1) = 7
var hammingCode7 = new HammingCode(textoCodificado, 8);

textoCodificado = noise.NoiseItUp(textoCodificado, p);
repetitionCode.BinaryData = noise.NoiseItUp(repetitionCode.BinaryData, p);
hammingCode15.BinaryData = noise.NoiseItUp(hammingCode15.BinaryData, p);
hammingCode7.BinaryData = noise.NoiseItUp(hammingCode7.BinaryData, p);

// Imprime os resultados
Console.WriteLine("Resultado para o texto sem correcao de erros:");
Console.WriteLine(codificador.BinarioParaTexto(textoCodificado));
Console.WriteLine("Resultado do teste de repeticao R(5,1,3):");
Console.WriteLine(codificador.BinarioParaTexto(repetitionCode.DecodeToBinary()));
Console.WriteLine("Resultado do teste de hamming C(15,11,3):");
Console.WriteLine(codificador.BinarioParaTexto(hammingCode15.DecodeToBinary()));
Console.WriteLine("Resultado do teste de hamming C(11,7,3):");
Console.WriteLine(codificador.BinarioParaTexto(hammingCode7.DecodeToBinary()));

// Decodificacao e recodificacao de imagem

byte[] b = File.ReadAllBytes("sprite.png");

string binaryImg = "";

foreach (var item in b)
{
    binaryImg += Convert.ToString(item, 2).PadLeft(8, '0');
}

var hamCode = new HammingCode(binaryImg, 16);
hamCode.BinaryData = noise.NoiseItUp(hamCode.BinaryData, p);

var decoded = hamCode.DecodeToBinary();

// convert binaryImg to byte array
byte[] bytes = new byte[decoded.Length / 8];
for (int i = 0; i < bytes.Length; i++)
{
    bytes[i] = Convert.ToByte(decoded.Substring(i * 8, 8), 2);
}

File.WriteAllBytes("sprite2.png", bytes);

// Cria o codificador de texto, que vai passar as mensagems de binario para string e vice versa.
var codificador = new Codificador();

var textoCodificado = codificador.TextoParaBinario(
    "Ola somos alunos de matematica discreta e estamos codificando esta mensagem e atuando varios niveis de ruido nela, e apos isso tentando corrigir os erros e a decodificar."
);

// Cria o codigo de repeticao, com repeticao tamanho 5.
var repetitionCode = new RepetitionCode(textoCodificado, 5);

// Cria o codigo de hamming com tamanho (16-1) = 15
var hammingCode16 = new HammingCode(textoCodificado, 16);

// Cria o codigo de hamming com tamanho (16-1) = 7
var hammingCode8 = new HammingCode(textoCodificado, 16);

Console.WriteLine("Texto codificado: " + textoCodificado);

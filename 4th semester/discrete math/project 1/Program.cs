var codificador = new Codificador();

// var textoCodificado = codificador.TextoParaBigNumber("ola estou testando essa bagaca");
// Console.WriteLine(textoCodificado.GetValue());
// Console.WriteLine(codificador.BigNumberParaTexto(textoCodificado));

Console.WriteLine("Bem vindo ao gerador de pares RSA");
Console.WriteLine(
    "\nNeste programa, vamos guia-lo para gerar um par de chaves RSA, que serão usadas para criptografar e descriptografar mensagens."
);
Console.WriteLine(
    "Para isso, vamos precisar de dois numeros primos grandes, que serao usados para gerar a chave publica e a chave privada."
);
Console.WriteLine("\n--Aperte qualquer tecla para prosseguir com a geracao--");
Console.ReadKey();

Console.WriteLine("\nGerando numeros primos de 512 bits...");
var p = new BigNumber(1);
var q = new BigNumber(1);

// Gerando numeros primos, e checando para que sejam dois numeros diferentes.
while (p.GetValue() == q.GetValue())
{
    p = BigNumber.RetorneProximoPrimo(512);
    q = BigNumber.RetorneProximoPrimo(512);
}

Console.WriteLine("\nNumeros primos p e q gerados!");

var n = BigNumber.Multiply(p, q);
var totient = BigNumber.Multiply(
    BigNumber.Subtract(p, new BigNumber(1)),
    BigNumber.Subtract(q, new BigNumber(1))
);
var epsilon = new BigNumber(3);

while (BigNumber.EuclidesExtendido(epsilon, totient)[0].GetValue() != 1)
{
    epsilon = BigNumber.Add(epsilon, new BigNumber(2));
}

var d = BigNumber.CongruenciaLinear(epsilon, new BigNumber(1), totient)[0];
Console.WriteLine("\nn, epsilon, d, e funcao totient gerados!");

Console.WriteLine("\nSalvando a chave publica (epsilon,n), e a chave privada d em arquivos");

string[] _publicKeyA = new string[2];

_publicKeyA[0] = codificador.BigNumberParaTexto(epsilon);
_publicKeyA[1] = codificador.BigNumberParaTexto(n);

await SaveHandler.WriteToFile(_publicKeyA, "pub_rsa");

string[] _privateKeyA = new string[2];

_privateKeyA[0] = codificador.BigNumberParaTexto(d);
_privateKeyA[1] = codificador.BigNumberParaTexto(n);

await SaveHandler.WriteToFile(_privateKeyA, "priv_rsa");

Console.WriteLine("\nChaves publica e privada salvas em arquivos!");

Console.WriteLine(
    "\nVamos agora codificar e decodificar a frase: 'sou aluno de matematica discreta'"
);

string codificado = RSA.Codificar("sou aluno de matematica discreta", _publicKeyA);

Console.WriteLine("\nFrase codificada: " + codificado);

string decodificado = RSA.Decodificar(codificado, _privateKeyA);

Console.WriteLine("\nFrase decodificada: '" + decodificado + "'");

Console.WriteLine(
    "\nInsira uma frase a ser codificada, lembrando que ela deve ter no maximo 430 caracteres, e deve ser toda minuscula apenas com letras de a-z e espaco."
);

var fraseDoUsuario = Console.ReadLine();

if (fraseDoUsuario is null)
{
    fraseDoUsuario = "A frase nao foi valida!";
}

codificado = RSA.Codificar(fraseDoUsuario, _publicKeyA);

Console.WriteLine("\nFrase codificada: " + codificado);

decodificado = RSA.Decodificar(codificado, _privateKeyA);

Console.WriteLine("\nFrase decodificada: '" + decodificado + "'");

Console.WriteLine("\nAgora o programa ira assinar o texto, e verificar a assinatura");

var assinatura = RSA.Decodificar(fraseDoUsuario, _privateKeyA);

Console.WriteLine("\nAssinatura: " + assinatura);

decodificado = RSA.Codificar(assinatura, _publicKeyA);

Console.WriteLine("\nAssinatura verificada: " + decodificado.Equals(fraseDoUsuario));

Console.WriteLine(
    "\nVamos agora criar uma nova chave publica e privada para um usuario B, e usar as que ja foram geradas como as de usuario A para fazer autenticacao por assinatura digital."
);

Console.WriteLine(
    "O usuario A enviara uma mensagem para o usuario B, codificada com a chave publica de B, e assinada com a chave privada de A."
);

Console.WriteLine(
    "Apos isso, o usuario B, usando a chave privada B ira decodificar a mensagem, e usando a chave publica A, verificara que a mensagem foi de fato enviada por A"
);

Console.WriteLine("\n--Aperte qualquer botao para gerar as chaves de B--");

Console.ReadKey();

Console.WriteLine("\nGerando numeros primos de 512 bits...");
p = new BigNumber(1);
q = new BigNumber(1);

// Gerando numeros primos, e checando para que sejam dois numeros diferentes.
while (p.GetValue() == q.GetValue())
{
    p = BigNumber.RetorneProximoPrimo(512);
    q = BigNumber.RetorneProximoPrimo(512);
}

Console.WriteLine("\nNumeros primos p e q gerados!");

n = BigNumber.Multiply(p, q);
totient = BigNumber.Multiply(
    BigNumber.Subtract(p, new BigNumber(1)),
    BigNumber.Subtract(q, new BigNumber(1))
);
epsilon = new BigNumber(3);

while (BigNumber.EuclidesExtendido(epsilon, totient)[0].GetValue() != 1)
{
    epsilon = BigNumber.Add(epsilon, new BigNumber(2));
}

d = BigNumber.CongruenciaLinear(epsilon, new BigNumber(1), totient)[0];
Console.WriteLine("\nn, epsilon, d, e funcao totient gerados!");

string[] _publicKeyB = new string[2];

_publicKeyB[0] = codificador.BigNumberParaTexto(epsilon);
_publicKeyB[1] = codificador.BigNumberParaTexto(n);

string[] _privateKeyB = new string[2];

_privateKeyB[0] = codificador.BigNumberParaTexto(d);
_privateKeyB[1] = codificador.BigNumberParaTexto(n);

Console.WriteLine("\nChaves de B geradas!");

Console.WriteLine("\nEscreva a mensagem que deseja enviar para o usuario B");

fraseDoUsuario = Console.ReadLine();

if (fraseDoUsuario is null)
{
    fraseDoUsuario = "A frase nao foi valida!";
}

codificado = RSA.Codificar(fraseDoUsuario, _publicKeyB);
assinatura = RSA.Codificar(fraseDoUsuario, _privateKeyA);

Console.WriteLine("\nFrase codificada: " + codificado);

Console.WriteLine("\nAssinatura: " + assinatura);

decodificado = RSA.Codificar(codificado, _privateKeyB);

Console.WriteLine("\nFrase decodificada com a chave privada B: '" + decodificado + "'");

decodificado = RSA.Codificar(assinatura, _publicKeyA);

Console.WriteLine(
    "\nVerificando se a frase foi assinada por A: " + decodificado.Equals(fraseDoUsuario)
);

Console.WriteLine("\n--Aperte qualquer botao para finalizar o programa--");

Console.ReadKey();

Environment.Exit(0);

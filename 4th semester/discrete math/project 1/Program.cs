// var Codificador = new Codificador();
// var textoCodificado = Codificador.TextoParaInteiro("aaaaaah");
// Console.WriteLine(textoCodificado);
// Console.WriteLine(Codificador.InteiroParaTexto(textoCodificado));

BigNumber bigNumber = new BigNumber(3, 2);

Console.WriteLine(BigNumber.Mod(bigNumber, new BigNumber(2, 2)).GetValue());

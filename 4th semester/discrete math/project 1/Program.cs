// var Codificador = new Codificador();
// var textoCodificado = Codificador.TextoParaInteiro("aaaaaah");
// Console.WriteLine(textoCodificado);
// Console.WriteLine(Codificador.InteiroParaTexto(textoCodificado));

BigNumber bigNumber = new BigNumber(16);

Console.WriteLine(
    BigNumber.CongruenciaLinear(new BigNumber(15), new BigNumber(9), new BigNumber(18))[
        4
    ].GetValue()
);

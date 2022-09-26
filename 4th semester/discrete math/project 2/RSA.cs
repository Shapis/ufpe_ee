class RSA
{
    public static string Codificar(string texto, string[] publicKey)
    {
        var codificador = new Codificador();
        var epsilon = codificador.TextoParaBigNumber(publicKey[0]);
        var n = codificador.TextoParaBigNumber(publicKey[1]);
        var textoBN = codificador.TextoParaBigNumber(texto);

        var y = codificador.BigNumberParaTexto(BigNumber.ExpMod(textoBN, epsilon, n));

        return y;
    }

    public static string Decodificar(string texto, string[] privateKey)
    {
        var codificador = new Codificador();
        var d = codificador.TextoParaBigNumber(privateKey[0]);
        var n = codificador.TextoParaBigNumber(privateKey[1]);
        var textoBN = codificador.TextoParaBigNumber(texto);

        var z = codificador.BigNumberParaTexto(BigNumber.ExpMod(textoBN, d, n));

        // Console.WriteLine(z);

        return z;
    }
}

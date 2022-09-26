using System.Numerics;

class Codificador
{
    public BigNumber BigNumberParaBinario(BigNumber bigNumber)
    {
        var binario = new BigNumber(0);
        var potencia = new BigNumber(1);
        while (bigNumber.GetValue() > 0)
        {
            var resto = BigNumber.Mod(bigNumber, new BigNumber(2));
            binario = BigNumber.Add(binario, BigNumber.Multiply(resto, potencia));
            bigNumber = BigNumber.Divide(bigNumber, new BigNumber(2));
            potencia = BigNumber.Multiply(potencia, new BigNumber(10));
        }
        return binario;
    }

    public BigNumber BinarioParaBigNumber(BigNumber binario)
    {
        var bigNumber = new BigNumber(0);
        var potencia = new BigNumber(1);
        while (binario.GetValue() > 0)
        {
            var resto = BigNumber.Mod(binario, new BigNumber(10));
            bigNumber = BigNumber.Add(bigNumber, BigNumber.Multiply(resto, potencia));
            binario = BigNumber.Divide(binario, new BigNumber(10));
            potencia = BigNumber.Multiply(potencia, new BigNumber(2));
        }
        return bigNumber;
    }

    public int TextoParaInteiro(string texto)
    {
        int numero = 0;
        for (int i = 0; i < texto.Length; i++)
        {
            if ((int)texto[i] >= (int)'a' && (int)texto[i] <= (int)'z')
            {
                numero += (1 + (int)texto[i] - (int)'a') * (int)Math.Pow(27, i);
            }
            else if ((int)texto[i] == (int)' ')
            {
                numero += 27 * (int)Math.Pow(27, i);
            }
        }
        return numero;
    }

    public BigNumber TextoParaBigNumber(string texto)
    {
        BigInteger numero = new BigInteger(0);
        for (int i = 0; i < texto.Length; i++)
        {
            if ((BigInteger)texto[i] >= (BigInteger)'a' && (BigInteger)texto[i] <= (BigInteger)'z')
            {
                numero += (1 + (BigInteger)texto[i] - (BigInteger)'a') * BigInteger.Pow(27, i);
            }
            else if ((int)texto[i] == (int)' ')
            {
                numero += 27 * BigInteger.Pow(27, i);
            }
        }
        return new BigNumber(numero);
    }

    //Converts BigNumber to text
    public string BigNumberParaTexto(BigNumber bigNumber)
    {
        string texto = "";
        BigInteger numero = bigNumber.GetValue();
        while (numero > 0)
        {
            if (numero % 27 == 0)
            {
                texto += " ";
                numero -= 1;
            }
            else
            {
                texto += (char)((BigInteger)'a' + numero % 27 - 1);
            }
            numero /= 27;
        }
        return texto;
    }

    public string InteiroParaTexto(int numero)
    {
        string texto = "";
        while (numero > 0)
        {
            var resto = numero % 27;
            if (resto == 0)
            {
                texto += ' ';
                numero -= 1;
            }
            else
            {
                texto += (char)(resto + (int)'a' - 1);
            }

            numero /= 27;
        }
        return texto;
    }
}

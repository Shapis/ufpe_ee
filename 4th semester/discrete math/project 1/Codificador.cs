class Codificador
{
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

class Codificador
{
    public int TextoParaInteiro(string texto)
    {
        int numero = 0;
        for (int i = 0; i < texto.Length; i++)
        {
            if ((int)texto[i] >= (int)'a' && (int)texto[i] <= (int)'z')
            {
                numero += (int)texto[i] - (int)'A';
            }
            // numero += (int)texto[i];
        }
        return numero;
    }

    public string InteiroParaTexto(int numero)
    {
        string texto = "";
        while (numero > 0)
        {
            texto += (char)numero % 256;
            numero /= 256;
        }
        return texto;
    }
}

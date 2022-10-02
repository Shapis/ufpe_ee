using System.Numerics;

class Codificador
{
    public string TextoParaBinario(string texto)
    {
        string binario = "";
        foreach (char c in texto)
        {
            binario += System.Convert.ToString(c, 2).PadLeft(8, '0');
        }
        return binario;
    }

    public string BinarioParaTexto(string binario)
    {
        string texto = "";
        for (int i = 0; i < binario.Length; i += 8)
        {
            texto += System.Convert.ToChar(System.Convert.ToByte(binario.Substring(i, 8), 2));
        }
        return texto;
    }
}

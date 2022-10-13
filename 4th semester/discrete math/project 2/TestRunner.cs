using System.Numerics;

class TestRunner
{
    Noise noise = new Noise();

    public void TestarPorcentagemDeErroPorBitRepeticao(
        int n,
        List<float> SNRdb,
        List<float> SNR,
        float p,
        string textoCodificado,
        int iteracoes = 100
    )
    {
        var R = 1f / (float)n;
        for (int i = 0; i < SNRdb.Count; i++)
        {
            Console.WriteLine("SNRdb: " + SNRdb[i]);
            // Cria a funcao erro que vai computar a probabilidade p de cada bit ser alterado.
            p = (float)ErrorFunction.Erfc(Math.Sqrt(2 * R * SNR[i]));

            BigInteger quantidadeDeErros = 0;
            BigInteger quantidadeDeIteracoes = 0;
            //Console.WriteLine(p);

            while (quantidadeDeErros <= iteracoes)
            {
                var rc = new RepetitionCode(textoCodificado, n);
                rc.BinaryData = noise.NoiseItUp(rc.BinaryData, p);
                var limpo = rc.DecodeToBinary();
                for (int j = 0; j < limpo.Length; j++)
                {
                    if (limpo[j] != textoCodificado[j])
                    {
                        quantidadeDeErros++;
                    }
                    quantidadeDeIteracoes++;
                }
            }
            //Console.WriteLine(p);
            Console.WriteLine((double)quantidadeDeErros / (double)quantidadeDeIteracoes);
        }
    }

    public void TestarPorcentagemDeErroPorBitHamming(
        int n,
        int k,
        List<float> SNRdb,
        List<float> SNR,
        float p,
        string textoCodificado,
        int iteracoes = 100
    )
    {
        var R = (float)k / (float)n;
        for (int i = 0; i < SNRdb.Count; i++)
        {
            Console.WriteLine("SNRdb: " + SNRdb[i]);
            // Cria a funcao erro que vai computar a probabilidade p de cada bit ser alterado.
            p = (float)ErrorFunction.Erfc(Math.Sqrt(2 * R * SNR[i]));

            BigInteger quantidadeDeErros = 0;
            BigInteger quantidadeDeIteracoes = 0;
            //Console.WriteLine(p);

            while (quantidadeDeErros <= iteracoes)
            {
                var hc = new HammingCode(textoCodificado, (int)n + 1);
                hc.BinaryData = noise.NoiseItUp(hc.BinaryData, p);
                var limpo = hc.DecodeToBinary();
                for (int j = 0; j < limpo.Length; j++)
                {
                    if (limpo[j] != textoCodificado[j])
                    {
                        quantidadeDeErros++;
                    }
                    quantidadeDeIteracoes++;
                }
            }
            //Console.WriteLine(p);
            Console.WriteLine((double)quantidadeDeErros / (double)quantidadeDeIteracoes);
        }
    }

    public void TestarPorcentagemDeErroPorBitSemCodigo(
        List<float> SNRdb,
        List<float> SNR,
        float p,
        string textoCodificado,
        int iteracoes = 100
    )
    {
        var R = 1f;
        for (int i = 0; i < SNRdb.Count; i++)
        {
            Console.WriteLine("SNRdb: " + SNRdb[i]);
            // Cria a funcao erro que vai computar a probabilidade p de cada bit ser alterado.
            p = (float)ErrorFunction.Erfc(Math.Sqrt(2 * R * SNR[i]));

            BigInteger quantidadeDeErros = 0;
            BigInteger quantidadeDeIteracoes = 0;
            //Console.WriteLine(p);

            while (quantidadeDeErros <= iteracoes)
            {
                var textoNoiseado = noise.NoiseItUp(textoCodificado, p);
                for (int j = 0; j < textoNoiseado.Length; j++)
                {
                    if (textoNoiseado[j] != textoCodificado[j])
                    {
                        quantidadeDeErros++;
                    }
                    quantidadeDeIteracoes++;
                }
            }
            //Console.WriteLine(p);
            Console.WriteLine((double)quantidadeDeErros / (double)quantidadeDeIteracoes);
        }
    }
}

var codificador = new Codificador();
var textoCodificado = codificador.TextoParaBigNumber("ola estou testando essa bagaca");
Console.WriteLine(textoCodificado.GetValue());
Console.WriteLine(codificador.BigNumberParaTexto(textoCodificado));

// List<BigNumber> abc = new List<BigNumber>();
// for (int i = 0; i < 1000; i++)
// {
//     abc.Add(BigNumber.RetorneProximoPrimo(256));
// }

// if (abc.Distinct().Count() != abc.Count())
// {
//     Console.WriteLine("Repetidos");
// }

// foreach (var item in abc)
// {
//     Console.WriteLine(item.GetValue());
// }



// BigNumber bigNumber = new BigNumber(16);

// Console.WriteLine(
//     BigNumber.CongruenciaLinear(new BigNumber(2, 10), new BigNumber(2, 11), new BigNumber(2, 300))[
//         0
//     ].GetValue()
// );

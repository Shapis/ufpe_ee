using System.Numerics;

public class BigNumber
{
    BigInteger bigInteger = new BigInteger();
    private int _maxBitSize = 2048;

    public BigNumber(int i, int n)
    {
        bigInteger = BigInteger.Pow(i, n);
        SizeSafetyCheck();
    }

    public BigNumber(int i, int n, int plus)
    {
        bigInteger = BigInteger.Pow(i, n);
        bigInteger += plus;
        SizeSafetyCheck();
    }

    public BigNumber(BigInteger n)
    {
        bigInteger = n;
        SizeSafetyCheck();
    }

    private void SizeSafetyCheck()
    {
        if (GetBitLength() > _maxBitSize)
        {
            Console.WriteLine("Numero eh grande demais para ser guardado em um BigNumber.");
            throw new Exception("Bit size exceeded");
        }
    }

    public BigInteger GetValue()
    {
        return bigInteger;
    }

    public int GetBitLength()
    {
        return (int)bigInteger.GetBitLength();
    }

    public static BigNumber Add(BigNumber a, BigNumber b)
    {
        var temp = new BigNumber(a.bigInteger + b.bigInteger);
        temp.SizeSafetyCheck();
        return temp;
    }

    public static BigNumber Subtract(BigNumber a, BigNumber b)
    {
        var temp = new BigNumber(a.bigInteger - b.bigInteger);
        temp.SizeSafetyCheck();
        return temp;
    }

    public static BigNumber Multiply(BigNumber a, BigNumber n)
    {
        var temp = new BigNumber(a.bigInteger * n.bigInteger);
        temp.SizeSafetyCheck();
        return temp;
    }

    public static BigNumber Divide(BigNumber a, BigNumber n)
    {
        var temp = new BigNumber(a.bigInteger / n.bigInteger);
        temp.SizeSafetyCheck();
        return temp;
    }

    public static BigNumber Mod(BigNumber a, BigNumber n)
    {
        var temp = new BigNumber(a.bigInteger % n.bigInteger);
        temp.SizeSafetyCheck();
        return temp;
    }

    public static BigNumber AddMod(BigNumber a, BigNumber b, BigNumber n)
    {
        var temp = new BigNumber(a.bigInteger + BigNumber.Mod(b, n).bigInteger);
        temp.SizeSafetyCheck();
        return temp;
    }

    public static BigNumber MulMod(BigNumber a, BigNumber b, BigNumber n)
    {
        var temp = new BigNumber(a.bigInteger * BigNumber.Mod(b, n).bigInteger);
        temp.SizeSafetyCheck();
        return temp;
    }

    // Inspirado em: https://www.geeksforgeeks.org/solve-linear-congruences-ax-b-mod-n-for-values-of-x-in-range-0-n-1/
    public static BigNumber[] EuclidesExtendido(BigNumber a, BigNumber b)
    {
        // Base Case
        if (a.GetValue() == new BigNumber(0).GetValue())
        {
            return new BigNumber[] { b, new BigNumber(0), new BigNumber(1) };
        }
        else
        {
            // Store the result of recursive call
            BigNumber x1 = new BigNumber(1),
                y1 = new BigNumber(1);
            BigNumber[] gcdy = EuclidesExtendido(BigNumber.Mod(b, a), a);
            BigNumber gcd = gcdy[0];
            x1 = gcdy[1];
            y1 = gcdy[2];

            // Update x and y using results of
            // recursive call
            BigNumber y = x1;
            BigNumber x = BigNumber.Subtract(y1, BigNumber.Multiply((BigNumber.Divide(b, a)), x1));

            return new BigNumber[] { gcd, x, y };
        }
    }

    public static List<BigNumber> CongruenciaLinear(BigNumber a, BigNumber b, BigNumber n)
    {
        a = BigNumber.Mod(a, n);
        b = BigNumber.Mod(b, n);

        // var u = new BigNumber(0);
        // var v = new BigNumber(0);

        var euclides = EuclidesExtendido(a, n);
        var d = euclides[0];
        var u = euclides[1];
        var v = euclides[2];

        // No solution exists
        if (BigNumber.Mod(b, d).GetValue() != new BigNumber(0).GetValue())
        {
            Console.WriteLine("Nao existe solucao para esta congruencia linear!");
            return new List<BigNumber>();
        }

        // Else, initialize the value of x0
        BigNumber x0 = BigNumber.Mod((BigNumber.Multiply(u, BigNumber.Divide(b, d))), n);
        if (x0.GetValue() < new BigNumber(0).GetValue())
        {
            x0 = BigNumber.Add(x0, n);
        }

        var bigNumbers = new List<BigNumber>();
        for (
            BigNumber i = new BigNumber(0);
            i.GetValue() <= BigNumber.Subtract(d, new BigNumber(1)).GetValue();
            i = BigNumber.Add(i, new BigNumber(1))
        )
        {
            BigNumber an = BigNumber.Mod(
                (BigNumber.Add(x0, BigNumber.Multiply(i, BigNumber.Divide(n, d)))),
                n
            );
            bigNumbers.Add(an);
        }

        return bigNumbers;
    }

    public static BigNumber RetorneProximoPrimo(int n)
    {
        Random rng = new Random();
        var bn = new BigNumber(2, n, -1);

        var randomNumber = rng.Next(1, n);
        var isPrime = false;

        while (!isPrime)
        {
            randomNumber = rng.Next(1, n);
            isPrime = MillerRabin.IsProbablePrime(bn.GetValue(), 2);

            if (isPrime)
            {
                break;
            }
            else
            {
                bn = BigNumber.Subtract(bn, new BigNumber(2 * randomNumber));
            }
        }
        return bn;
    }
}

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

    public BigNumber(int i, int n, int minus)
    {
        bigInteger = BigInteger.Pow(i, n);
        bigInteger -= minus;
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
            Console.WriteLine("The number is too big to be stored in a BigInteger.");
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
}

# PYTHON EXPORT MDC(n1,n2)

from math import *
import sys

n1 = int(sys.argv[0])
n2 = int(sys.argv[1])


def mdc(a, b):
    if b > a:
        a, b = b, a
    if b == 0:
        return a
    x = [1, 0]
    y = [0, 1]
    r = [b, b]
    print('\n a\tb\tr\tq\txn\tyn')
    while (r[1] != 0):
        q = a // b
        r[1] = a % b
        xn = x[0] - (q * x[1])
        yn = y[0] - (q * y[1])
        print('', a, '\t', b, '\t', r[1], '\t', q, '\t', xn, '\t', yn)
        x[0] = x[1]
        x[1] = xn
        y[0] = y[1]
        y[1] = yn
        a = b
        b = r[1]
        if (r[1] != 0):
            r[0] = r[1]
    return r[0], x[0], y[0]


list = mdc(n1, n2)
print()
print('MDC: ', list[0])
print('Xn: ', list[1])
print('Yn: ', list[2])


# end

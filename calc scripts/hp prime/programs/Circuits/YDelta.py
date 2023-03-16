# PYTHON EXPORT YDelta(n1,n2,n3)

import sys

n1 = float(sys.argv[0])
n2 = float(sys.argv[1])
n3 = float(sys.argv[1])


def ydelta(Ra, Rb, Rc):
    print(Ra, ' \\', ' ', '|', Rb, '|', ' ', '/ ', Rc)

    sum = (Ra*Rb + Rb*Rc + Rc*Ra)

    R1 = sum / Rc
    R2 = sum / Rb
    R3 = sum / Ra

    print(R1, ' |', ' ', '-- ', R2, '--', ' ', '| ', R3)
    return [R1, R3, R2]


ydelta(n1, n2, n3)

# end

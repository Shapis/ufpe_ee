# PYTHON EXPORT DeltaY(n1,n2,n3)

import sys

n1 = float(sys.argv[0])
n2 = float(sys.argv[1])
n3 = float(sys.argv[1])


def deltay(Ra, Rb, Rc):
    print(Ra, ' |', ' ', '-- ', Rb, '--', ' ', '| ', Rc)

    sum = (Ra+Rb+Rc)
    R1 = Ra * Rb / sum
    R2 = Rb * Rc / sum
    R3 = Rc * Ra / sum

    print(R1, ' \\', ' ', '|', R3, '|', ' ', '/ ', R2)

    return [R1, R3, R2]


deltay(n1, n2, n3)

# end

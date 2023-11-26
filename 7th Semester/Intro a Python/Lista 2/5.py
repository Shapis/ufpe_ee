def NumeralPerfeito(n):
    soma = 0
    for i in range(1, n):
        if n % i == 0:
            soma += i
    if soma == n:
        return True
    else:
        return False


def NumerosPerfeitos(n):
    lista = []
    for i in range(1, n + 1):
        if NumeralPerfeito(i):
            lista.append(i)
    return lista


print(NumerosPerfeitos(500))

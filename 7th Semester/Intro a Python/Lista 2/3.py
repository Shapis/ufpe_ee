def PotenciasMenores(n):
    lista = []
    for i in range(0, n):
        if 2**i < n:
            lista.append(2**i)
        else:
            break
    return lista


print(PotenciasMenores(9))

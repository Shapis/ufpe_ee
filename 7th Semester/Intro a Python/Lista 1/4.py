def AcheNumeroSuperiorAoLimites(lista, limiteSuperior):
    for i in range(len(lista)):
        if lista[i] > limiteSuperior:
            return i
    return -1


print(AcheNumeroSuperiorAoLimites(range(10), 11))

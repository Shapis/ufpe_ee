def NumerosUnicos(lista):
    lista2 = []
    for i in lista:
        if i not in lista2:
            lista2.append(i)
    return len(lista2)


print(NumerosUnicos([1, 2, 3, 4, 5, 5, 5, 6, 7, 8, 8]))

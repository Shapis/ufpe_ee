def RecebeDoisNumeros(n1, n2, limite):
    temp = 0
    if n1 > limite:
        temp += 1
    if n2 > limite:
        temp += 1
    return temp


print(RecebeDoisNumeros(1, 4, 3))

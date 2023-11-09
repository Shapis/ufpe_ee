lista = []
i = 0

while i < 5:
    lista.append(int(input("Digite um número: ")))
    i += 1

i = 0

while True:
    i = int(input("Digite o indice a ser exibido: ")) - 1

    if i == -1:
        break
    else:
        print(lista[i])

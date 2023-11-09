fila = list(range(10))

ordem = 0
while True:
    ordem = int(input("Digite 1 se chegou cliente, 2 para atender cliente: "))
    if ordem == 1:
        fila.append(input("Digite o nome do cliente: "))
    elif ordem == 2:
        if len(fila) == 0:
            print("Não há clientes na fila.")
        else:
            print(f"Cliente sendo atendido: {fila.pop(0)}")
    else:
        break

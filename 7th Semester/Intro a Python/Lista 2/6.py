import random


def DadoAleatorio():
    return random.randint(1, 6)


def RoleDadosVariasVezes(n):
    dicionario = {"1": 0, "2": 0, "3": 0, "4": 0, "5": 0, "6": 0}

    for i in range(0, n):
        match DadoAleatorio():
            case 1:
                dicionario["1"] += 1
            case 2:
                dicionario["2"] += 1
            case 3:
                dicionario["3"] += 1
            case 4:
                dicionario["4"] += 1
            case 5:
                dicionario["5"] += 1
            case 6:
                dicionario["6"] += 1

        # Nao entendi essa linha direito
        result_dict = {key: value / n for key, value in dicionario.items()}

    return result_dict


print(RoleDadosVariasVezes(10**6))

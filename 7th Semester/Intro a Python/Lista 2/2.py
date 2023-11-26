def Fibonacci(n):
    if n <= 1:
        return n
    else:
        return Fibonacci(n - 1) + Fibonacci(n - 2)


def ListaFibonacci(n):
    lista = []
    for i in range(0, n):
        lista.append(Fibonacci(i))
    return lista


print(ListaFibonacci(5))

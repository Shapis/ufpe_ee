def InteiroParaBinario(n):
    if n < 2:
        return str(n)
    else:
        return InteiroParaBinario(n // 2) + str(n % 2)


print(InteiroParaBinario(7))

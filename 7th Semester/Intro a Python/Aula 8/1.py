class ContaBancaria:
    def __init__(self, cliente, saldo):
        self.cliente = cliente
        self._saldo = saldo

    def sacar(self, valor):
        if valor <= self._saldo:
            self._saldo -= valor
            print("Saque efetuado com sucesso")
        else:
            print("Saldo insuficiente")

    def depositar(self, valor):
        self._saldo += valor
        print("Depósito efetuado com sucesso")

    def consultarSaldo(self):
        print(f"Saldo: {self._saldo}")

    @property
    def saldo(self):
        return self._saldo

    @saldo.setter
    def saldo(self, valor):
        raise ValueError(
            f"Você não pode alterar o saldo diretamente, utilize o metodo depositar({valor}) e o metodo sacar({valor})"
        )


class ContaCorrente(ContaBancaria):
    def __init__(self, cliente, saldo, cc):
        super().__init__(cliente, saldo)
        self._cc = cc

    def receberPix(self, valor):
        self._saldo += valor
        print("Pix recebido com sucesso")

    def enviarPix(self, valor):
        if valor <= self._saldo:
            self._saldo -= valor
            print("Pix efetuado com sucesso")
        else:
            print("Saldo insuficiente")

    @property
    def cc(self):
        return self._cc


minhaConta = ContaCorrente("Fulano", 0, 777)

minhaConta.depositar(100)

minhaConta.consultarSaldo()

print(f"Saldo: {minhaConta.saldo}")

# minhaConta.saldo = 50

minhaConta.enviarPix(2)

minhaConta.receberPix(10)

print(f"Saldo: {minhaConta.saldo}")
print(f"CC: {minhaConta.cc}")

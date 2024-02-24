class Aparelho:
    def __init__(self, nome):
        self.nome = nome

    def executarAcao(self):
        raise Exception("Acao nao implementada!")


class Termometro(Aparelho):
    pass


class Presenciometro(Aparelho):
    pass

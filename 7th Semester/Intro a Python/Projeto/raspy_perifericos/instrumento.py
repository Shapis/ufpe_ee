class Instrumento:
    def __init__(self, nome):
        self.nome = nome

    def lerMedida(self):
        raise Exception("Leitor nao implementado!")


class Termometro(Instrumento):
    pass


class Presenciometro(Instrumento):
    pass

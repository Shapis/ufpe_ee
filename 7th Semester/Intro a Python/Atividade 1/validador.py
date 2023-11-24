class validador:
    def __init__(self, frase, listaValidadora):
        self.frase = frase
        self.listaValidadora = listaValidadora

    def validar(self):
        while True:
            try:
                valor_selecionado = int(input(self.frase))
                if valor_selecionado > 0 and valor_selecionado <= len(
                    self.listaValidadora
                ):
                    return valor_selecionado
                else:
                    print("Valor inválido, tente novamente.")
            except ValueError:
                print("Valor inválido, tente novamente.")

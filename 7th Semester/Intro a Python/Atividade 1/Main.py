from CLP import CLP
from validador import validador

_numeroDeControladoresLogicos = 4

_controladoresLogicos = []

for i in range(0, _numeroDeControladoresLogicos):
    _controladoresLogicos.append(CLP("CLP_" + str(i + 1)))

print("Controladores Lógicos Disponiveis:")

for i in range(0, len(_controladoresLogicos)):
    print(str(i + 1) + " - " + _controladoresLogicos[i].nome)

valor_selecionado = validador(
    "Selecione o CLP a ser utilizado:", _controladoresLogicos
).validar()


_meuCLP = _controladoresLogicos[valor_selecionado - 1]

print("\nInstrumentos Disponiveis:")
for i in range(0, len(_meuCLP.instrumentos)):
    print(str(i + 1) + " - " + _meuCLP.instrumentos[i].nome)

valor_selecionado = validador(
    "Selecione o instrumento a ser utilizado:", _meuCLP.instrumentos
).validar()

_meuInstrumento = _meuCLP.instrumentos[valor_selecionado - 1]

print(
    f"\nLendo medida do {_meuInstrumento.nome} do {_meuCLP.nome}: {_meuInstrumento.lerMedida()}"
)

import mathplotlib


# Dados iniciais

ratos = 10000
gatos = 2

# Parametros

alpha = 2
# É a taxa máxima de crescimento para as presas.
beta = 1
# É um fator de desconto no crescimento das presas devido a presença de predadores.
delta = 0.1
# É taxa de crescimento da população de predadores devido a facilidade de encontrar presas para se alimentar
gamma = 1
# É um fator de desconto na taxa de crescimento da população de predadores devido a competição com outros predadores


semestres = 10

for i in range(10):
    print(ratos)
    ratos += alpha * ratos - beta * ratos * gatos
    ratos = max(ratos, 0)
    gatos += max(delta * ratos * gatos - gamma * gatos * gatos, 0)
    gatos = max(gatos, 0)

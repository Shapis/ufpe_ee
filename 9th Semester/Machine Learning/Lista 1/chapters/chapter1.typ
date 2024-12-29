#import "@preview/codly:1.1.1": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

= Introdução

Este relatório tem como objetivo analisar um conjunto de dados utilizando dois métodos clássicos de classificação: o Classificador Bayesiano com distribuição normal e o Método dos Mínimos Quadrados com matriz pseudo-inversa.

O Classificador Bayesiano assume que as variáveis seguem uma distribuição normal, calculando probabilidades para tomar decisões de classificação de forma probabilística. Já o Método dos Mínimos Quadrados minimiza os erros quadráticos entre os valores reais e preditos, sendo amplamente utilizado em problemas de regressão linear.

Para avaliar o desempenho de ambos os métodos, o conjunto de dados será dividido aleatoriamente em 80% para treinamento e 20% para teste. Assim, será possível comparar a eficácia e as características de cada abordagem na tarefa de classificação.

== Conjunto de dados

Utilizaremos um conjunto de dados de 2000 elementos, e o separamos em 80% para treinamento e 20% para teste.

#codly(languages: codly-languages)
```python
file_path = "dataset_ml20241212.csv"

data = pd.read_csv(file_path)

x = data.iloc[:, :-1].values
y = data.iloc[:, -1].values

x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.2, random_state=42
)
```
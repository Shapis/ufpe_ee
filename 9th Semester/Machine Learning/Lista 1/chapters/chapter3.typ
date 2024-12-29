#import "@preview/codly:1.1.1": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

= Classificador Método dos Mínimos Quadrados

Neste capítulo, vamos criar um classificador bayesiano e aplicá-lo ao nosso conjunto de dados.

== Passo a passo

Cria-se uma classe ```python class LeastSquares``` que contém os métodos ```python fit``` e ```python predict```.

#codly(languages: codly-languages)
```python
classificador_least_squares = ls.LeastSquares()
classificador_least_squares.fit(x_train, y_train)
y_prediction_ls = classificador_least_squares.predict(x_test)
```

=== Método ```python fit```

O metodo ```python fit``` calcula os coeficientes do modelo de regressão linear utilizando o método dos mínimos quadrados por matriz pseudo inversa.

#codly(languages: codly-languages)
```python
    def fit(self, X, y):
        X_b = np.c_[np.ones((X.shape[0], 1)), X]
        self.theta = np.linalg.inv(X_b.T.dot(X_b)).dot(X_b.T).dot(y)
```

=== Método ```python predict```

O método ```python predict``` realiza a predição do modelo de regressão linear e retorna o dicionário de predições.

#codly(languages: codly-languages)
```python
    def predict(self, X):    
        X_b = np.c_[np.ones((X.shape[0], 1)), X]
        predictions = X_b.dot(
            self.theta
        )
        return np.where(predictions <= 1.5, 1, 2)```

== Resultados

Os resultados obtidos das métricas de acurácia e MSE para o classificador do método dos mínimos quadrados são apresentados na tabela abaixo.

=== Tabela de métricas
#set align(center)

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Métrica*], [*Valor*],
  ),
  [Acurácia],  $ 0.9925 $,
  [MSE],  $ 0.01 $,
  [Desvio Padrão],  $ 0.09 $,
)

#set align(start + top)

=== Matriz confusão
$ mat(
  204, 3;
  0, 193;
) $






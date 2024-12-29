#import "@preview/codly:1.1.1": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

= Classificador Bayesiano

Neste capítulo, vamos criar um classificador bayesiano e aplicá-lo ao nosso conjunto de dados.


== Passo a passo

Cria-se uma classe ```python class NaiveBayesClassifier``` que contém os métodos ```python fit``` e ```python predict``` para treinar e prever os dados, respectivamente.

#codly(languages: codly-languages)
```python
classificador_bayes = nbc.NaiveBayesClassifier()
classificador_bayes.fit(x_train, y_train)
y_prediction_bayes = classificador_bayes.predict(x_test)
```

=== Método ```python fit```

O método ```python fit``` calcula a média e o desvio padrão de cada classe e de cada atributo do conjunto de treinamento.

#codly(languages: codly-languages)
```python
    def fit(self, x, y):
        self.classes = np.unique(y)  
        for cls in self.classes:
            x_cls = x[y == cls] 
            self.mean[cls] = np.mean(x_cls, axis=0)  
            self.var[cls] = np.var(x_cls, axis=0)  
            self.priors[cls] = (
                x_cls.shape[0] / x.shape[0]
            ) 
```

=== Método ```python predict```

O método ```python predict``` calcula a probabilidade de cada classe para cada instância do conjunto de teste e retorna a classe com maior probabilidade.

#codly(languages: codly-languages)
```python
    def predict(self, X):
        y_pred = [
            max(
                self._calculate_posterior(x), key=self._calculate_posterior(x).get
            ) 
            for x in X
        ]
        return np.array(y_pred)
```

Mas para calcular a probabilidade de cada classe, é necessário calcular a probabilidade a posteriori de cada classe para cada instância do conjunto de teste.

=== Método ```python _calculate_posterior```

O método ```python _calculate_posterior``` calcula a probabilidade a posteriori de cada classe para cada instância do conjunto de teste.

#codly(languages: codly-languages)
```python
    def _calculate_posterior(self, x):
        posteriors = {}  # Dicionário para armazenar os posteriors das classes
        for cls in self.classes:
            prior = np.log(self.priors[cls])  # Calcula o log da probabilidade a priori
            likelihood = np.sum(
                np.log(
                    self._calculate_likelihood(self.mean[cls], self.var[cls], x)
                )  # Calcula o log da verossimilhança
            )
            posteriors[cls] = (
                prior + likelihood
            )  # Calcula o posterior somando o log da prior e da verossimilhança
        return posteriors  # Retorna o dicionário com os posteriors para cada classe
```

Para calcular a verossimilhança, é necessário calcular a probabilidade de cada atributo para cada classe.

=== Método ```python _calculate_likelihood```

O método ```python _calculate_likelihood``` calcula a probabilidade de cada atributo para cada classe.

Para isso utiiza-se a fórmula da distribuição normal:

#figure(
  image("../images/bayes.png", width: 50%),
  caption: [
    Fórmula da distribuição normal de Bayes.
  ],
)
 <fig:bayes>

 Para obter a verossimilhança, é necessário calcular o coeficiente e o expoente da distribuição normal abaixo.

 

#codly(languages: codly-languages)
```python
        def _calculate_likelihood(self, mean, var, x):
        eps = 1e-6  # Constante pequena para evitar problemas numéricos por divisao por zero.
        coeff = 1.0 / np.sqrt(
            2.0 * np.pi * var + eps
        )  # Cálculo do coeficiente da distribuição normal
        exponent = np.exp(
            -((x - mean) ** 2) / (2 * var + eps)
        )  # Cálculo do expoente da distribuição normal
        return coeff * exponent  # Retorna a verossimilhança
```

== Resultados

Os resultados obtidos das métricas de acurácia e MSE para o classificador bayesiano são apresentados na tabela abaixo.



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

=== Matriz Confusão
$ mat(
  204, 3;
  0, 193;
) $






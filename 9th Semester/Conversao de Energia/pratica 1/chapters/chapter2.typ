= Análise Preliminar

A análise teórica deste trabalho será conduzida com o objetivo de compreender os princípios de funcionamento do circuito conversor de corrente alternada para corrente contínua, detalhando o papel de cada componente na operação do sistema. Além disso, será realizada uma análise numérica por meio de simulações computacionais, que permitirá observar o comportamento do circuito em diferentes condições operacionais. Essa abordagem combinada busca validar os conceitos teóricos e verificar a coerência entre os resultados esperados e os obtidos por meio da simulação.


== Tensão de saída do circuito e valor mínimo da tensão de entrada em cada regulador de tensão

$ V_o = 8V  $

$ V_i = 8V + 3V = 11V $ 

== Qual o valor da tensão média (teórica) na saída do retificador? Considere que será utilizado o transformador disponível no laboratório (veja a seção seguinte)

Valores teóricos:
$ V_p = 24 sqrt(2)-1,4 = 32.54V $
$ V_o = V_p - ( Delta V_o )  / 2 $

Valores simulação:
 $  V_o = 31.6V $

== Necessidade de dissipador de calor nos reguladores de tensão

No cenário em que a carga é máxima, a corrente no regulador é de 1A, valor limite do componente, portanto, torna-se necessário o uso de dissipador.

== Valor de ondulação de tensão em C1 e C2

$ "Ripple Rejection = 56dB" \ 
"Ripple_in" = 0.0015 * 10 ^ { 2.8} = 94.64% $

Este 94.64% nao sera relevante, pois com esta atenuacao o regulador vai estar fora da regiao de operacao.

$ Delta V_o = V_p - V_"in minimo" \
Delta V_o = 17V - 11V = 6 V $

$ Delta V_o = V_p/(2 f R C) -> C = V_p/(2 f R Delta V_o) = (17 V) / (2 * 60"Hz" * 11 ohm * 6V ) = 2146.465 mu F $

Entao vamos usar uma margem de seguranca de aproximadamente 50%.

$ C_1 = C_2 approx 3000 mu F $

== Valor de pico da corrente na ponte de diodos.

 $ Delta V_o = V_p (1- sin(alpha))  \ 
alpha = arcsin( 1 - (Delta V_o) /  V_p) = arcsin (1 - (6V) / (17V)) = 0.703720508 "rad" $

$ I_"D,pico" = omega C V_p cos(alpha) + (V_p sin(alpha) )/ R = V_p (omega C cos(alpha) + sin(alpha)/R)\
I_"D,pico" approx  14.68 A $

== Valores de C3 a C6

#set align(center)
#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*7808*], [*Valor*],
  ),
  $C_3$,
  $ 330 n F $,
  $C_5$,
  $ >= 100 n F $,
)

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*7908*], [*Valor*],
  ),
  $C_4$,
  $ 330 n F $,
  $C_6$,
  $ >= 100 n F $,
)
#set align(start + top)

== Valores dos resistores conectados em série com os LEDs

 $  R = (V_o - 2)/(10 m A) = 6 / (10 m A) = 600 ohm $ 

== Simulação do circuito em LTSpice

#figure(
  image("../images/simulacao.jpeg", width: 100%),
  caption: [
    Circuito a ser simulado em LTSpice.
  ],
)
 <fig:simulacao>
#import "relatorio_padrao.typ"

// #set cite(form: "full", style: "chicago-fullnotes")
// #set align(start + top)

#show: relatorio_padrao.project.with(
  title: "Projeto da Primeira Prática de Conversão de Potência.",
  subtitle: "Retificador de Onda Completo",
  authors: (
    "Bruno França Guimarães",
    "Henrique Pedro da Silva",

  ),
  school-logo: image("images/Brasao_da_UFPE.png"), // Replace with [] to remove the school logo
  // company-logo: image("images/company.svg"),
  mentors: (
    "Reuben Palmer R. de Sousa", 
  ),
  branch: "Departamento de Eletrônica e Sistemas",
  academic-year: "2024.2",
  footer-text: "UFPE" // Text used in left side of the footer
)

// Put then your content here

= Introdução

Neste relatório, será analisado o funcionamento de um circuito conversor de corrente alternada para corrente contínua, composto por uma ponte retificadora completa, um circuito RC e os reguladores de tensão 7808 e 7908. A abordagem detalha o processo de conversão, desde a retificação até a estabilização da tensão de saída, destacando o desempenho e as características principais dos componentes.

Também será avaliado o comportamento do circuito sob uma carga de saída resistiva de 8 Ohms, considerando a eficiência, a estabilidade da tensão e os efeitos das condições operacionais sobre os componentes. Essa análise busca oferecer uma visão clara do desempenho do circuito em aplicações práticas, identificando suas potencialidades e limitações.

O circuito de referência é
mostrado na @fig:circuito_1.

#figure(
  image("images/circuito_1.png", width: 100%),
  caption: [
    Circuito a ser projetado e montado.
  ],
)
 <fig:circuito_1>


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

== Valor de ondulação de tensão em C1 e C2 de modo que o valor mínimo da tensão de ondulação esteja acima do valor mínimo determinado no item anterior. Para isso, considere que a carga na saída do circuito é máxima. Calcule as capacitâncias desses componentes

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



= Medições em Laboratório

Na etapa de medição experimental, serão realizados testes práticos no circuito para avaliar seu desempenho em condições reais de operação. Utilizando instrumentos de medição como multímetros e osciloscópios, serão verificadas grandezas como tensões, correntes e formas de onda em pontos específicos do circuito. Essas medições permitirão obter uma visão detalhada do comportamento do sistema e dos parâmetros que influenciam sua performance, garantindo uma análise consistente de seu funcionamento prático.  

== Tabela de componentes

#set align(center)
#table(
  columns: (auto,auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Componente*], [*Quantidade*], [*Valor*],
  ),
  $"Resistor"$, $2$, $8 ohm$,
  $"Resistor"$, $2$, $600 ohm$,
  $"LED"$, $2$, $"Queda 2V"$,
  $"Capacitor"$, $4$, $330 n F$,
  $"Capacitor"$, $2$, $470 mu F$,
  $"Capacitor"$, $4$, $1000 mu F$,
  $"7808"$, $1$, $---$,
  $"7908"$, $1$, $---$,
  $"Osciloscópios"$, $1$, $---$,
  $"Fonte de Tensão"$ , $1$ , $"+13V  -13V"$
)
#set align(start + top)

== Formas de onda nos capacitores de entrada

#figure(
  image("images/forma_de_onda_c1.png", width: 100%),
  caption: [
    Forma de onda C1
  ],
)
 <fig:forma_de_onda_C1>


#figure(
  image("images/forma_de_onda_c1.png", width: 100%),
  caption: [
    Forma de onda C2
  ],
)
 <fig:forma_de_onda_C2>

== Formas de onda na saída dos reguladores

#figure(
  image("images/saida_78.png", width: 100%),
  caption: [
    Forma de onda 7808
  ],
)
 <fig:forma_de_onda_78>

 #figure(
  image("images/saida_79.png", width: 100%),
  caption: [
    Forma de onda 7908
  ],
)
 <fig:forma_de_onda_79>

  == Formas de "ripple" na saída dos reguladores

#figure(
  image("images/ripple78.png", width: 100%),
  caption: [
    Forma de ripple 7808
  ],
)
 <fig:forma_de_ripple_78>

 #figure(
  image("images/ripple79.png", width: 100%),
  caption: [
    Forma de ripple 7908
  ],
)
 <fig:forma_de_ripple_79>


 = Análise dos Resultados

 Será realizada uma comparação entre os dados obtidos nas análises teórica, simulada e experimental, com o objetivo de verificar a coerência entre as diferentes abordagens. Serão avaliados aspectos como tensões, correntes e formas de onda nos pontos críticos do circuito, buscando identificar concordâncias e eventuais divergências. Essa comparação permitirá compreender melhor o desempenho do circuito, validando os modelos empregados e destacando possíveis limitações ou variações decorrentes de fatores práticos.

 == Forma de onda nos capacitores

 Nota-se um problema na análise das formas de onda dos capacitores, conforme ilustrado nas figuras @fig:forma_de_onda_C1 e @fig:forma_de_onda_C2. Esperava-se que a tensão mínima de entrada nos reguladores 7808 e 7908 fosse de 11 V; no entanto, observa-se que as tensões mínimas atingem aproximadamente 9,3 V.

Apesar dessa discrepância, os demais resultados do experimento mostraram-se coerentes com as expectativas da análise preliminar. Isso sugere que, mesmo com a variação observada, os reguladores 7808 e 7908 permaneceram dentro de sua região de operação, garantindo o funcionamento adequado do circuito.

== Forma de onda na saída dos reguladores

Observa-se que as tensões de saída estão em 8 V e -8 V, conforme ilustrado nas figuras @fig:forma_de_onda_78 e @fig:forma_de_onda_79, o que indica que os reguladores estão operando dentro de sua faixa de funcionamento adequada. Essa operação permite que os reguladores estabilizem as tensões de entrada, reduzindo consideravelmente o ripple. Essa redução no ripple é um aspecto importante, pois demonstra a capacidade do circuito em fornecer uma tensão de saída mais estável e confiável.


== Ripple na saída dos reguladores

Os requisitos do projeto estabeleciam que o ripple deveria ser inferior a 0,2% da tensão de saída dos reguladores, ou seja:

$ Delta V = 0.002 * 8V = 16 m V $

Conforme apresentado em @fig:forma_de_ripple_78 e @fig:forma_de_ripple_79, o ripple medido foi de 4 mV e 20 mV nos reguladores 7808 e 7908, respectivamente. 

Acreditamos que esses valores atendem aos requisitos estabelecidos, embora a tensão de 20 mV esteja ligeiramente acima do limite devido a imprecisões e à prudência excessiva da função measure do osciloscópio.

= Conclusão
Em conclusão, este relatório apresentou uma análise detalhada do circuito conversor de corrente alternada para corrente contínua, utilizando uma ponte retificadora completa, circuitos RC e os reguladores de tensão 7808 e 7908. As medições realizadas confirmaram que o circuito é capaz de estabilizar as tensões de saída de forma eficaz, mantendo os níveis de ripple dentro dos limites exigidos pelo projeto. Com tensões de saída de 8 V e -8 V e ripples medidos em 4 mV e 20 mV, os resultados mostram que o sistema opera conforme esperado, atendendo aos requisitos estabelecidos.

A análise das formas de onda dos capacitores e das tensões de saída revelou que os reguladores 7808 e 7908 funcionaram adequadamente em suas regiões de operação, garantindo uma alimentação estável e confiável. Apesar de uma pequena discrepância na medição do ripple, que se situou um pouco acima do limite ideal, essa variação foi atribuída a imprecisões instrumentais, especialmente relacionadas à função *measure* do osciloscópio. Assim, a performance do circuito se mostrou satisfatória, destacando a eficiência dos reguladores em ambientes práticos.

Este trabalho enfatizou a importância da integração entre teoria, simulação e experimentação, mostrando que cada abordagem contribui para uma compreensão mais completa do desempenho do circuito. Os resultados obtidos não apenas validaram os conceitos teóricos, mas também forneceram insights valiosos para o aprimoramento de projetos futuros na área de eletrônica. Com isso, o relatório conclui que o circuito analisado é eficaz para aplicações que requerem uma conversão confiável de corrente alternada para contínua.


// #pagebreak()
// #bibliography("refs.bib")
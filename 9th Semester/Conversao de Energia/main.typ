#import "relatorio_padrao.typ"

// #set cite(form: "full", style: "chicago-fullnotes")
// #set align(start + top)

#show: relatorio_padrao.project.with(
  title: "Projeto da Primeira Prática de Conversão de Potência.",
  subtitle: "Retificador de Onda Completo",
  authors: (
    "Bruno França",
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


= Preparação para o experimento (Análise Teórica)

Todas as etapas e resultados obtidos a seguir devem ser incluídos no relatório da prática.
Lembre-se de cumprir todas as especificações de projeto. O circuito de referência é
mostrado na @fig:circuito_1.

#figure(
  image("images/circuito_1.png", width: 100%),
  caption: [
    Circuito a ser projetado e montado.
  ],
)
 <fig:circuito_1>

 #pagebreak()


== Defina o valor da tensão de saída do circuito. Qual o valor mínimo da tensão de entrada em cada regulador de tensão?

$ V_o = 8V  $

$ V_i = 8V + 3V = 11V $ 

(datasheet 7808 e 7908) 

== Qual o valor da tensão média (teórica) na saída do retificador? Considere que será utilizado o transformador disponível no laboratório (veja a seção seguinte)

Valores teoricos: 
$ V_p = 24 sqrt(2)-1,4 = 32.54V $
$ V_o = V_p - ( Delta V_o )  / 2 $

Valores simulacao:

 $  V_o = 31.6V $

== É preciso utilizar um dissipador de calor nos reguladores de tensão? Pesquise sobre e explique o porquê. Considere o cenário em que a carga é máxima.

Sim! No cenário em que a carga é máxima, a corrente no regulador é de 1A, valor limite do componente, portanto, torna-se necessário o uso de dissipador.

== Defina um valor de ondulação de tensão em C1 e C2 de modo que o valor mínimo da tensão de ondulação esteja acima do valor mínimo determinado no item anterior. Para isso, considere que a carga na saída do circuito é máxima. Calcule as capacitâncias desses componentes.

$ "Ripple Rejection = 56dB" \ 
"Ripple_in" = 0.0015 * 10 ^ { 2.8} = 94.64% $

Este 94.64% nao sera relevante, pois com esta atenuacao o regulador vai estar fora da regiao de operacao.

$ Delta V_o = V_p - V_"in minimo" \
Delta V_o = 17V - 11V = 6 V $

$ Delta V_o = V_p/(2 f R C) -> C = V_p/(2 f R Delta V_o) = (17 V) / (2 * 60"Hz" * 11 ohm * 6V ) = 2146.465 mu F $

Entao vamos usar uma margem de seguranca de aproximadamente 50%.

$ C_1 = C_2 approx 3000 mu F $

== Calcule o valor de pico da corrente na ponte de diodos. Julgue se os componentes disponíveis no laboratório suportam esse valor de corrente.

 $ Delta V_o = V_p (1- sin(alpha))  \ 
alpha = arcsin( 1 - (Delta V_o) /  V_p) = arcsin (1 - (6V) / (17V)) = 0.703720508 "rad" $

$ I_"D,pico" = omega C V_p cos(alpha) + (V_p sin(alpha) )/ R = V_p (omega C cos(alpha) + sin(alpha)/R)\
I_"D,pico" approx  14.68 A $

== Consulte o datasheet dos reguladores de tensão e a partir das aplicações típicas, defina os valores de C3 a C6.

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
  $C_6$,
  $ >= 100 n F $,
)

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*7908*], [*Valor*],
  ),
  $C_3$,
  $ 330 n F $,
  $C_6$,
  $ >= 100 n F $,
)
#set align(start + top)

== Calcule os valores dos resistores conectados em série com os LEDs.



 $  R = (V_o - 2)/(10 m A) = 6 / (10 m A) = 600 ohm $ 
 

== Simule o circuito e compare com os resultados obtidos através da análise teórica.


// #pagebreak()
// #bibliography("refs.bib")
= Medições em Laboratório

Na etapa de medição experimental, serão realizados testes práticos no circuito para avaliar seu desempenho em condições reais de operação. Utilizando instrumentos de medição como multímetros e osciloscópios, serão verificadas grandezas como tensões, correntes e formas de onda em pontos específicos do circuito. Essas medições permitirão obter uma visão detalhada do comportamento do sistema e dos parâmetros que influenciam sua performance, garantindo uma análise consistente de seu funcionamento prático.  

#figure(
  image("../images/foto_circuito.jpeg", width: 100%),
  caption: [
    Foto do circuito montado em laboratório
  ],
)
 <fig:foto_do_circuito>



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
  image("../images/forma_de_onda_c1.png", width: 100%),
  caption: [
    Forma de onda C1
  ],
)
 <fig:forma_de_onda_C1>


#figure(
  image("../images/forma_de_onda_c1.png", width: 100%),
  caption: [
    Forma de onda C2
  ],
)
 <fig:forma_de_onda_C2>

== Formas de onda na saída dos reguladores

#figure(
  image("../images/saida_78.png", width: 100%),
  caption: [
    Forma de onda 7808
  ],
)
 <fig:forma_de_onda_78>

 #figure(
  image("../images/saida_79.png", width: 100%),
  caption: [
    Forma de onda 7908
  ],
)
 <fig:forma_de_onda_79>

  == Formas de "ripple" na saída dos reguladores

#figure(
  image("../images/ripple78.png", width: 100%),
  caption: [
    Forma de ripple 7808
  ],
)
 <fig:forma_de_ripple_78>

 #figure(
  image("../images/ripple79.png", width: 100%),
  caption: [
    Forma de ripple 7908
  ],
)
 <fig:forma_de_ripple_79>
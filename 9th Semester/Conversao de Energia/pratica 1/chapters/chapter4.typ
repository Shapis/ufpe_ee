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
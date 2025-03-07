#import "@preview/diatypst:0.3.0": *

#set text(lang: "pt")
#set cite(form: "full", style: "chicago-fullnotes")

#show: slides.with(
  title: "Condutividade elétrica e potencial eletroquímico.",
  subtitle: "Tecnologia dos Materiais 2024.2",
  date: "07.03.2025",
  authors: ("Aluno: Henrique Pedro da Silva\nProfessor: Edval J. P. Santos, PhD\nRepositório: https://github.com/shapis/ufpe_ee/"),
  ratio: 16/9,
  layout: "medium",
  title-color: blue.darken(60%),
  toc: true,
  count: false,
)

#let fonte(body, fill: white) = {
  set text(black)
  set align(end+bottom)
  rect(
    fill: fill,
    inset: 5pt,
    radius: 5pt,
    [Fonte: #body.],
  )
}

#set align(start + horizon)

= Introdução e Motivação

== Introdução

A condutividade elétrica nos semicondutores é um tema fundamental para a eletrônica moderna. O transporte de carga ocorre por dois mecanismos principais: deriva e difusão. Esses processos são essenciais para o funcionamento de dispositivos semicondutores, como transistores e diodos. A compreensão desses fenômenos remonta ao século XX, com o avanço da física do estado sólido e da engenharia de materiais.

#fonte[@callister]

== Motivação

Com a compreensão profunda de como os portadores de carga se movem e interagem, podemos criar dispositivos eletroeletrônicos mais sofisticados, eficientes e precisos, abrindo caminho para inovações tecnológicas que aprimoram o desempenho e a funcionalidade dos sistemas eletrônicos em diversas áreas.

#fonte[@callister]

== Um circuito elétrico simples

#figure(
  image("circuito_simples.png", width: 60%),
  caption: [
    Circuito elétrico simples, com apenas uma fonte e uma carga resistiva.
  ],
)
 <fig:circuit>
 #fonte[@veritasium]
 == Quanto tempo para a luz acender?

#figure(
  image("circuito_simples_pergunta.png", width: 90%),
  caption: [
    Circuito elétrico simples, com apenas uma fonte e uma carga resistiva.
  ],
)
 <fig:circuit>


= Intuição Física: Parte 1

==  Elétrons esbarrando em cristais?

Talvez uma maneira de compreender o movimento das partículas carregadas em um cristal é imaginar que os elétrons são atraídos pelos núcleos atômicos. No entanto, um campo elétrico pode superar essa barreira de potencial, liberando-os para se mover livremente, seguindo exclusivamente a direção e a intensidade desse campo. Esse comportamento pode ser comparado ao de uma bola de bilhar em uma mesa, esbarrando em outras bolas e, no caso dos elétrons, também interagindo com outros núcleos ao longo de seu trajeto.

#fonte[@veritasium]

== Estrutura Cristalina

#figure(
  image("fluorite-from-atoms.jpg", width:40%),
  caption: [
    Modelo da estrutura atômica da Fluorita.
  ],
)
 <fig:modelo_esfera_rigida>

== Uma nuvem de elétrons em movimento?

Outra maneira de visualizar o movimento dos elétrons em um cristal é pensar em uma nuvem de elétrons que se move coletivamente, respondendo a um campo elétrico aplicado. Essa nuvem de elétrons pode ser considerada como um fluido que flui através do cristal, interagindo com os átomos e outras partículas ao longo do caminho. Essa abordagem ajuda a entender como a condutividade elétrica é afetada por fatores como a densidade de portadores de carga e a mobilidade dos elétrons.

#fonte[@veritasium]

= Experimento de Stephen Grays

== Stephen Grays

Stephen Gray foi um cientista inglês que realizou experimentos pioneiros sobre a eletricidade e a condutividade elétrica no século XVIII. Ele descobriu que a eletricidade pode ser transmitida através de materiais condutores, como metais, e isolantes, como vidro. Seus experimentos ajudaram a estabelecer as bases da teoria da eletricidade e a compreensão dos fenômenos elétricos.

#fonte[@stephengray]

== Stephen Grays

#figure(
  image("stephen_grays.png", width:35%),
  caption: [
    Dezembro 1666 - 7 Fevereiro 1736
  ],
)
 <fig:modelo_esfera_rigida>

#fonte[@stephengray]

== A Hipótese de Stephen Grays

Stephen Gray propôs que a eletricidade é transmitida através de um "éter elétrico" que permeia todos os materiais. Esse éter é responsável por transportar a carga elétrica de um ponto a outro, permitindo a condução da eletricidade. Essa hipótese foi posteriormente refutada por outros cientistas, que desenvolveram teorias mais precisas sobre a condutividade elétrica e o movimento dos elétrons em materiais condutores.

#fonte[@stephengrayexperiment]

== Estrutura do Experimento

#figure(
  image("floating_boy.png", width:60%),
  caption: [
    Garoto pendurado por fio não condutor sendo ionizado por um bastão de vidro.
  ],
)
 <fig:modelo_esfera_rigida>

#fonte[@stephengrayexperiment]

= Formalismo Matemático

== Corrente de Difusão
 
#figure(
  image("Ficks-First-Law.jpg", width:55%),
  caption: [
    Primeira lei de Fick.
  ],
)
 <fig:modelo_esfera_rigida>
 
#fonte[@fick]

== Corrente de Difusão
 
#figure(
  image("Ficks-Second-Law.jpg", width:55%),
  caption: [
    Segunda lei de Fick.
  ],
)
 <fig:modelo_esfera_rigida>
 
#fonte[@fick]

== Velocidade de Deriva

$ F = m a \
q E = m^*_p a \
integral a = integral (q E)/m^*_p \ 
v(t)  = (q E)/m^*_p t \
v_m (t)  = E q/m^*_p tau_i \
v_m (t) = E mu $

#fonte[@jordan]

== Velocidade de Deriva

#figure(
  image("u_p.png", width:45%),
  caption: [
    Explicação de $mu$ efetivo.
  ],
)
 <fig:modelo_esfera_rigida>

 #fonte[@jordan]

 == Velocidade de Deriva

 $ v_m(t) = u_p E $

  #fonte[@jordan]


 == Corrente de Deriva

#figure(
  image("andy1.png", width:65%),
  caption: [
    Equação da corrente de deriva.
  ],
)
 <fig:modelo_esfera_rigida>

  #fonte[@andy]

   == Corrente de Deriva

#figure(
  image("andy2.png", width:65%),
  caption: [
    Equação da corrente de deriva.
  ],
)
 <fig:modelo_esfera_rigida>

  #fonte[@andy]

   == Corrente de Deriva

#figure(
  image("andy3.png", width:60%),
  caption: [
    Equação da corrente de deriva.
  ],
)
 <fig:modelo_esfera_rigida>

  #fonte[@andy]

  == Zona de Brillouin

#figure(
  image("brilloin.jpg", width:70%),
  caption: [
    Zona de Brillouin
  ],
)
 <fig:modelo_esfera_rigida>

  #fonte[@brillouin]

    == Banda de Condução
#figure(
  image("conduction_band.png", width:60%),
  caption: [
    Banda de Condução.
  ],
)
 <fig:modelo_esfera_rigida>

  #fonte[@conductionband]

  =  Intuição Física: Parte 2

  == Circuito com resistência

#figure(
  image("circuito_magnet1.png", width:55%),
  caption: [
    Campos magnéticos e elétricos de um circuito puramente resistivo.
  ],
)
 <fig:modelo_esfera_rigida>

  #fonte[@veritasium]

== Vetor de Poynting

#figure(
  image("poyinting.png", width:55%),
  caption: [
    Campos magnéticos e elétricos em fase de uma onda de luz.
  ],
)
 <fig:modelo_esfera_rigida>

  #fonte[@veritasium]

  == Circuito com resistência

#figure(
  image("circuit_magnet2.png", width:55%),
  caption: [
    Vetor de Poynting de todo o circuito.
  ],
)
 <fig:modelo_esfera_rigida>

  #fonte[@veritasium]

= Potencial eletroquímico no Semicondutor

== Nível de Fermi bandas de energia

#figure(
  image("femi_level1.png", width:35%),
  caption: [
    Bandas de energia de metal e semicondutor.
  ],
)

  #fonte[@fermi]

  == Nível de Fermi em semicondutor intrínseco

#figure(
  image("fermi_level2.png", width:55%),
  caption: [
    Nível de Fermi e energia de gap em semicondutor intrínseco.
  ],
)

  #fonte[@fermi]

    == Nível de Fermi em semicondutor dopado n

#figure(
  image("fermi_level3.png", width:55%),
  caption: [
    Nível de Fermi e energia de gap em semicondutor dopado n.
  ],
)

  #fonte[@fermi]

    == Nível de Fermi em semicondutor dopado p

#figure(
  image("fermi_level4.png", width:55%),
  caption: [
    Nível de Fermi e energia de gap em semicondutor dopado p.
  ],
)

  #fonte[@fermi]

  = Fontes do material, processo de obtenção e de manufatura

  == Fontes do Material

  Silício (Si) – O silício é o material semicondutor mais utilizado na fabricação de dispositivos eletrônicos, devido à sua abundância, custo acessível e propriedades favoráveis.

    Fonte natural: O silício é extraído da areia, que é composta principalmente de dióxido de silício (SiO2).
    Processo de obtenção: O silício é extraído da areia em um processo conhecido como redução carbônica, onde o SiO2 é aquecido com carbono para obter silício metálico.

      #fonte[@james]

  == Processo de Obtenção

    Purificação do Silício:
        O silício extraído da areia é purificado para obter silício de alta pureza (98% a 99% puro), utilizando técnicas como a redução de silício.
        O processo mais comum de purificação é a redução do dióxido de silício com carbono, seguido pela refinação de Czochralski para produzir silício monocristalino.

    Crescimento de Cristais:
        Após a purificação, o silício é moldado em barras ou lingotes monocristalinos através do método de Czochralski, onde um cristal de silício é puxado lentamente para formar um lingote de silício.
        Alternativamente, pode ser utilizado o processo float zone para formar cristais de alta pureza.

    Corte do Cristal:
        O lingote de silício é então cortado em waferes finos (fatias muito finas), utilizando serra diamantada ou outro processo de corte preciso.
        Os waferes são polidos para garantir uma superfície lisa e adequada para a fabricação de dispositivos semicondutores.
      #fonte[@james]
== Processo de Manufatura de Semicondutores

Dopagem:

    A dopagem é o processo de adicionar impurezas (dopantes) ao silício para alterar suas propriedades elétricas.
    Os dopantes mais comuns são o fósforo (P) e o boro (B), que criam regiões de tipo N (negativo) e tipo P (positivo), respectivamente, essenciais para a criação de diodos e transistores.

Oxidação:

    A oxidação do silício é realizada para formar uma camada de óxido de silício (SiO2) na superfície dos waferes. Esta camada serve como isolante e protetora durante os processos subsequentes de fabricação.

Litografia:

    A litografia é um processo essencial para criar padrões na superfície do wafer. Durante a litografia, uma camada de material fotossensível é aplicada no wafer, e a luz ultravioleta é usada para transferir um padrão da máscara para a superfície do wafer.
      #fonte[@james]
#pagebreak()
Deposição de Filmes Finos:

    Deposição de filmes finos pode ser realizada por técnicas como CVD (Chemical Vapor Deposition) ou PVD (Physical Vapor Deposition) para depositar camadas de materiais como metais, óxidos ou nitratos no wafer.

Gravação (Etching):

    O processo de gravação remove as áreas não desejadas dos materiais depositados ou da camada de óxido, utilizando produtos químicos ou plasmas.

Densificação e Testes:

    Após a fabricação dos dispositivos, a densificação do chip ocorre, onde o dispositivo é testado, cortado em formas pequenas (chips) e encapsulado.
    Testes rigorosos de desempenho e funcionalidade são realizados para garantir a qualidade e a precisão.
          #fonte[@james]

= Técnicas de Caracterização

== Medição de Resistividade Elétrica (Método de 4 Pontos)

Descrição: O método de quatro pontos (ou técnica de Van der Pauw) é amplamente utilizado para medir a resistividade de materiais semicondutores. Consiste em aplicar uma corrente elétrica entre dois pontos de um material e medir a tensão nos outros dois pontos, de forma a obter a resistividade sem influenciar as medições com a resistência do contato.

Aplicação: Esse método é utilizado para medir a resistividade de waferes de silício e outros materiais semicondutores.

Equipamento: Medidores de resistividade de quatro pontos, como o Prober de 4 Pontos.

== Método Hall

Descrição: O efeito Hall é uma das técnicas mais comuns para determinar a mobilidade dos portadores de carga e a densidade de portadores em um material semicondutor. Consiste em aplicar um campo magnético perpendicular a um fluxo de corrente elétrica e medir a diferença de potencial (tensão de Hall) gerada perpendicularmente ao campo magnético.

Aplicação: Determinação da condutividade elétrica de materiais semicondutores, como silício e germânio.

Equipamento: Sistema de medição de efeito Hall, que inclui uma fonte de corrente, um campo magnético e um voltímetro.

= Normas Técnicas Associadas

== IEC 60747 - Semiconductor Devices

Descrição: Esta norma da International Electrotechnical Commission (IEC) especifica os requisitos para dispositivos semicondutores, incluindo as características elétricas como a condutividade.

Aplicação: Essa norma abrange os testes de caracterização elétrica dos dispositivos semicondutores, como os transistores, e pode incluir diretrizes sobre os métodos de medição da resistividade e da mobilidade de portadores.

== ISO/IEC 17025 - Requisitos gerais para a competência de laboratórios de ensaio e calibração

Descrição: Embora não seja específica para semicondutores, essa norma define os requisitos para a competência dos laboratórios de ensaio, incluindo aqueles que realizam medições de condutividade elétrica em materiais semicondutores.

Aplicação: Ela assegura que os métodos de medição, como os testes de resistividade e mobilidade dos portadores, sejam realizados de forma confiável e repetível.

== ASTM F1241 - Standard Test Method for Hall Effect Measurements

Descrição: A ASTM F1241 especifica o método de medição do efeito Hall para determinar a mobilidade dos portadores de carga e a densidade de portadores em materiais semicondutores.

Aplicação: Esta norma é importante para a caracterização de materiais semicondutores, como silício e arseneto de gálio, para dispositivos como transistores de efeito de campo (FETs).

== ASTM D257 - Standard Test Methods for DC Resistance or Conductance of Insulating Materials

Descrição: Esta norma descreve métodos para testar a resistência elétrica em materiais isolantes, que pode ser uma referência quando se estudam materiais semicondutores em dispositivos de isolamento.

Aplicação: Pode ser útil para avaliar materiais usados em dispositivos semicondutores e em sistemas de isolamento elétrico.

== JIS C 2550-3 - Semiconductor materials - Resistivity measurement

Descrição: Norma japonesa que especifica os métodos para medir a resistividade de materiais semicondutores.

Aplicação: Usada para definir os métodos de medição de resistividade de waferes de silício e outros materiais semicondutores, com foco em precisão e repetibilidade.



 = Bibliografia

 == Fontes
#set align(left + top)

#bibliography("refs.bib") 




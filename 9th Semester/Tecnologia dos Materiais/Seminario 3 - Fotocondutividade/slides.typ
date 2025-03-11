#import "@preview/diatypst:0.3.0": *

#set text(lang: "pt")
#set cite(form: "full", style: "chicago-fullnotes")

#show: slides.with(
  title: "Fotocondutividade",
  subtitle: "Tecnologia dos Materiais 2024.2",
  date: "08.03.2025",
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

A fotocondutividade é um fenômeno no qual a condutividade elétrica de um material aumenta quando ele é exposto à luz. Isso ocorre porque os fótons incidentes fornecem energia suficiente para excitar elétrons da banda de valência para a banda de condução, gerando pares elétron-lacuna e reduzindo a resistência elétrica do material. Esse efeito é amplamente utilizado em dispositivos como fotodetectores, células solares e sensores ópticos. A fotocondutividade depende de fatores como o tipo de material, a intensidade e o comprimento de onda da luz incidente.

#fonte[@callister]

== Motivação

- Desenvolvimento de sensores e detectores ópticos – A fotocondutividade é a base para a fabricação de fotodetectores usados em câmeras, scanners, sistemas de segurança e telecomunicações.

- Avanços em células solares – O entendimento desse fenômeno contribui para melhorar a eficiência dos painéis solares, otimizando a conversão de luz em eletricidade.

- Pesquisa em novos materiais – O estudo da fotocondutividade ajuda a desenvolver materiais semicondutores inovadores, como perovskitas e nanomateriais, que podem revolucionar a eletrônica e a fotônica.

- Aplicações na indústria e medicina – Equipamentos como sensores biomédicos, monitores de radiação e dispositivos de visão noturna utilizam o princípio da fotocondutividade para funcionar de maneira eficiente.


= Intuição Física

== Sem Luz

A intuição física sobre a fotocondutividade pode ser compreendida a partir da interação entre luz e os elétrons de um material, principalmente em semicondutores. Aqui está um jeito simples de visualizar esse fenômeno:

*O material é menos condutor.*

Em muitos materiais, como semicondutores, os elétrons estão inicialmente presos em estados de baixa energia na banda de valência.
Como poucos elétrons estão disponíveis para transportar corrente, o material tem alta resistência elétrica.


== Com luz

*Aumento da condutividade*

Quando o material é iluminado, os fótons da luz fornecem energia suficiente para excitar os elétrons, promovendo-os da banda de valência para a banda de condução.

Isso cria pares elétron-lacuna, onde os elétrons livres podem se mover e contribuir para o fluxo de corrente elétrica.

A presença desses portadores adicionais reduz a resistência elétrica do material, tornando-o mais condutor.

*Depende da energia dos fótons*

Se a luz incidente tiver fótons com energia menor que a largura da banda proibida do material, nada acontece, pois não há energia suficiente para excitar os elétrons.
Se a energia for suficiente, mais elétrons são excitados, aumentando a condutividade do material.

== Interrupção da luz

*Volta ao estado original.*

Quando a luz é desligada, os elétrons e lacunas tendem a recombinar, reduzindo novamente a condutividade do material. 

O tempo que isso leva depende das características do material.

= Experimento de Willoughby Smith

== Descoberta da fotosensitividade no Selênio.

#figure(
  image("willoughby.png", width: 90%),
)
 #fonte[@willoughby]

== Hipótese de Willoughby Smith

A hipótese do experimento de Willoughby Smith não era originalmente sobre a fotocondutividade. Ele estava investigando a possibilidade de usar o selênio como um material com resistência elétrica estável para melhorar os sistemas de telégrafo submarino.

No entanto, ao perceber que a resistência do selênio variava inesperadamente, ele formulou uma nova hipótese.

 #fonte[@willoughby]

 == Hipótese de Willoughby Smith

 *A condutividade elétrica do selênio pode ser influenciada por fatores externos, como a exposição à luz.*

 Para testar essa ideia, ele realizou experimentos controlados, nos quais o selênio foi exposto e depois protegido da luz, verificando a mudança na resistência elétrica. Seus testes confirmaram que a luz reduzia a resistência do material, levando à descoberta do fenômeno da fotocondutividade.

 #fonte[@willoughby]

== Equipamentos Utilizados na Época

- Amostras de selênio em barras ou discos metálicos.

- Bateria química (pilhas de Daniell ou Grove) para fornecer corrente elétrica.

- Eletrodos metálicos para conectar as amostras de selênio ao circuito.

- Galvanômetro de bobina móvel para medir a corrente elétrica que passava pelo material.

- Fontes de luz natural e artificial, incluindo a luz solar e possivelmente lâmpadas incandescentes primitivas ou velas.

 #fonte[@willoughby]

== Preparação do Circuito

Smith montou um circuito simples, onde uma barra de selênio era conectada entre dois eletrodos metálicos.

Uma bateria química aplicava uma tensão fixa ao circuito, e a corrente era medida pelo galvanômetro.

 #fonte[@willoughby]

== Medição da Condutividade Sem Luz

No início, ele mediu a resistência elétrica do selênio em um ambiente escuro ou sombreado.

Os valores indicavam uma resistência muito alta, sugerindo que o material conduzia pouca eletricidade.

 #fonte[@willoughby]

 == Exposição à Luz e Medição

 Quando o selênio foi exposto à luz do sol, a corrente elétrica aumentou significativamente, indicando que a resistência elétrica havia diminuído.

Para confirmar o efeito, ele cobriu novamente a amostra, e a resistência voltou a aumentar.

O efeito foi repetido várias vezes, e os resultados mostraram que o fenômeno era reversível e reprodutível.
 #fonte[@willoughby]

 == Impacto da Descoberta

Essa foi a primeira evidência experimental de que a luz poderia influenciar a condutividade elétrica de um material, abrindo caminho para o desenvolvimento de tecnologias baseadas na fotocondutividade, como fotodetectores, células solares e sensores ópticos.

A descoberta de Smith também motivou estudos sobre os semicondutores, levando a avanços fundamentais na eletrônica e na fotônica (optoeletrônica?).

#fonte[@willoughby]

= Formalismo Matemático

== Equacoeess

alguma considerada

#fonte[@willoughby]

= Manufatura

== Escolha do Material Fotocondutor

Os materiais semicondutores usados em LDRs são geralmente sulfeto de cádmio (CdS), sulfeto de chumbo (PbS) ou seleneto de cádmio (CdSe). O CdS é o mais popular devido à sua boa resposta à luz visível.

#fonte[@cds]

== Resposta à luz


#figure(
  image("cds_resposta_luz.png", width: 65%),
  caption: [
    Resposta do CdS à luz.
  ],
)


#fonte[@cds]

== Resposta do CdS


#figure(
  image("cds5.jpg", width: 60%),
  caption: [
    Resposta relativa do sulfeto de cádmio (CdS), CdSe e CD(S.Se) à luz.
  ],
)


#fonte[@cds_direct]

== Construção

#figure(
  image("LDR.png", width: 30%),
  caption: [
    O material sensível a luz do LDR fica em zigue-zague para ter a resistência desejada e é depositado em um substrato de cerâmica.
  ],
)

#fonte[@cds]

== Diagrama do LDR

#figure(
  image("ScreenHunter49.png", width: 40%),
  caption: [
    Diagrama do LDR.
  ],
)

#fonte[@cds]

== Esquemático do LDR

#figure(
  image("ScreenHunter50.png", width: 40%),
  caption: [
    Esquemático do LDR.
  ],
)

#fonte[@cds]

= Normas 

== IEC 60747-5-5

Esta norma da Comissão Eletrotécnica Internacional especifica os requisitos para dispositivos semicondutores optoeletrônicos, incluindo fotodiodos e fototransistores, que operam com base na fotocondutividade.

== JEDEC JESD235

Emitida pelo JEDEC Solid State Technology Association, esta norma aborda os padrões para sensores de imagem, que utilizam a fotocondutividade em sua operação.

= Aplicações

== Sensor de luz

#figure(
  image("ScreenHunter51.png", width: 25%),
  caption: [
    No circuito da esquerda a tensão de saída (no Out) aumenta quando há incidência de luz no LDR e no circuito da direita é o contrário, tensão no “Out” diminui com a incidência de luz. Você pode ligar a saída destes circuitos na entrada analógica de algum microcontrolador. Ou pode ligar a saída na base de um transistor para acionar leds, relés, motores, etc. No circuito abaixo você pode substituir o led e o R2 por um relé ou um motor.
  ],
)
#fonte[@cds]

== Oscilador Astável 555

#figure(
  image("ScreenHunter52.png", width: 20%),
  caption: [
    Uum circuito oscilador o astável 555 com um resistor trocado por LDR, osciladores sempre tem resistores pois a frequência de oscilação depende deles. Pode-se criar um oscilador controlado por luz.
  ],
)
#fonte[@cds]
// == Um circuito elétrico simples

// #figure(
//   image("circuito_simples.png", width: 60%),
//   caption: [
//     Circuito elétrico simples, com apenas uma fonte e uma carga resistiva.
//   ],
// )
//  <fig:circuit>
//  #fonte[@veritasium]
//  == Quanto tempo para a luz acender?

// #figure(
//   image("circuito_simples_pergunta.png", width: 90%),
//   caption: [
//     Circuito elétrico simples, com apenas uma fonte e uma carga resistiva.
//   ],
// )
//  <fig:circuit>


// = Intuição Física: Parte 1

// ==  Elétrons esbarrando em cristais?

// Talvez uma maneira de compreender o movimento das partículas carregadas em um cristal é imaginar que os elétrons são atraídos pelos núcleos atômicos. No entanto, um campo elétrico pode superar essa barreira de potencial, liberando-os para se mover livremente, seguindo exclusivamente a direção e a intensidade desse campo. Esse comportamento pode ser comparado ao de uma bola de bilhar em uma mesa, esbarrando em outras bolas e, no caso dos elétrons, também interagindo com outros núcleos ao longo de seu trajeto.

// #fonte[@veritasium]

// == Estrutura Cristalina

// #figure(
//   image("fluorite-from-atoms.jpg", width:40%),
//   caption: [
//     Modelo da estrutura atômica da Fluorita.
//   ],
// )
//  <fig:modelo_esfera_rigida>

// == Uma nuvem de elétrons em movimento?

// Outra maneira de visualizar o movimento dos elétrons em um cristal é pensar em uma nuvem de elétrons que se move coletivamente, respondendo a um campo elétrico aplicado. Essa nuvem de elétrons pode ser considerada como um fluido que flui através do cristal, interagindo com os átomos e outras partículas ao longo do caminho. Essa abordagem ajuda a entender como a condutividade elétrica é afetada por fatores como a densidade de portadores de carga e a mobilidade dos elétrons.

// #fonte[@veritasium]

// = Experimento de Stephen Grays

// == Stephen Grays

// Stephen Gray foi um cientista inglês que realizou experimentos pioneiros sobre a eletricidade e a condutividade elétrica no século XVIII. Ele descobriu que a eletricidade pode ser transmitida através de materiais condutores, como metais, e isolantes, como vidro. Seus experimentos ajudaram a estabelecer as bases da teoria da eletricidade e a compreensão dos fenômenos elétricos.

// #fonte[@stephengray]

// == Stephen Grays

// #figure(
//   image("stephen_grays.png", width:35%),
//   caption: [
//     Dezembro 1666 - 7 Fevereiro 1736
//   ],
// )
//  <fig:modelo_esfera_rigida>

// #fonte[@stephengray]

// == A Hipótese de Stephen Grays

// Stephen Gray propôs que a eletricidade é transmitida através de um "éter elétrico" que permeia todos os materiais. Esse éter é responsável por transportar a carga elétrica de um ponto a outro, permitindo a condução da eletricidade. Essa hipótese foi posteriormente refutada por outros cientistas, que desenvolveram teorias mais precisas sobre a condutividade elétrica e o movimento dos elétrons em materiais condutores.

// #fonte[@stephengrayexperiment]

// == Estrutura do Experimento

// #figure(
//   image("floating_boy.png", width:60%),
//   caption: [
//     Garoto pendurado por fio não condutor sendo ionizado por um bastão de vidro.
//   ],
// )
//  <fig:modelo_esfera_rigida>

// #fonte[@stephengrayexperiment]

// = Formalismo Matemático

// == Corrente de Difusão
 
// #figure(
//   image("Ficks-First-Law.jpg", width:55%),
//   caption: [
//     Primeira lei de Fick.
//   ],
// )
//  <fig:modelo_esfera_rigida>
 
// #fonte[@fick]

// == Corrente de Difusão
 
// #figure(
//   image("Ficks-Second-Law.jpg", width:55%),
//   caption: [
//     Segunda lei de Fick.
//   ],
// )
//  <fig:modelo_esfera_rigida>
 
// #fonte[@fick]

// == Velocidade de Deriva

// $ F = m a \
// q E = m^*_p a \
// integral a = integral (q E)/m^*_p \ 
// v(t)  = (q E)/m^*_p t \
// v_m (t)  = E q/m^*_p tau_i \
// v_m (t) = E mu $

// #fonte[@jordan]

// == Velocidade de Deriva

// #figure(
//   image("u_p.png", width:45%),
//   caption: [
//     Explicação de $mu$ efetivo.
//   ],
// )
//  <fig:modelo_esfera_rigida>

//  #fonte[@jordan]

//  == Velocidade de Deriva

//  $ v_m(t) = u_p E $

//   #fonte[@jordan]


//  == Corrente de Deriva

// #figure(
//   image("andy1.png", width:65%),
//   caption: [
//     Equação da corrente de deriva.
//   ],
// )
//  <fig:modelo_esfera_rigida>

//   #fonte[@andy]

//    == Corrente de Deriva

// #figure(
//   image("andy2.png", width:65%),
//   caption: [
//     Equação da corrente de deriva.
//   ],
// )
//  <fig:modelo_esfera_rigida>

//   #fonte[@andy]

//    == Corrente de Deriva

// #figure(
//   image("andy3.png", width:60%),
//   caption: [
//     Equação da corrente de deriva.
//   ],
// )
//  <fig:modelo_esfera_rigida>

//   #fonte[@andy]

//   == Zona de Brillouin

// #figure(
//   image("brilloin.jpg", width:70%),
//   caption: [
//     Zona de Brillouin
//   ],
// )
//  <fig:modelo_esfera_rigida>

//   #fonte[@brillouin]

//     == Banda de Condução
// #figure(
//   image("conduction_band.png", width:60%),
//   caption: [
//     Banda de Condução.
//   ],
// )
//  <fig:modelo_esfera_rigida>

//   #fonte[@conductionband]

//   =  Intuição Física: Parte 2

//   == Circuito com resistência

// #figure(
//   image("circuito_magnet1.png", width:55%),
//   caption: [
//     Campos magnéticos e elétricos de um circuito puramente resistivo.
//   ],
// )
//  <fig:modelo_esfera_rigida>

//   #fonte[@veritasium]

// == Vetor de Poynting

// #figure(
//   image("poyinting.png", width:55%),
//   caption: [
//     Campos magnéticos e elétricos em fase de uma onda de luz.
//   ],
// )
//  <fig:modelo_esfera_rigida>

//   #fonte[@veritasium]

//   == Circuito com resistência

// #figure(
//   image("circuit_magnet2.png", width:55%),
//   caption: [
//     Vetor de Poynting de todo o circuito.
//   ],
// )
//  <fig:modelo_esfera_rigida>

//   #fonte[@veritasium]

// = Potencial eletroquímico no Semicondutor

// == Nível de Fermi bandas de energia

// #figure(
//   image("femi_level1.png", width:35%),
//   caption: [
//     Bandas de energia de metal e semicondutor.
//   ],
// )

//   #fonte[@fermi]

//   == Nível de Fermi em semicondutor intrínseco

// #figure(
//   image("fermi_level2.png", width:55%),
//   caption: [
//     Nível de Fermi e energia de gap em semicondutor intrínseco.
//   ],
// )

//   #fonte[@fermi]

//     == Nível de Fermi em semicondutor dopado n

// #figure(
//   image("fermi_level3.png", width:55%),
//   caption: [
//     Nível de Fermi e energia de gap em semicondutor dopado n.
//   ],
// )

//   #fonte[@fermi]

//     == Nível de Fermi em semicondutor dopado p

// #figure(
//   image("fermi_level4.png", width:55%),
//   caption: [
//     Nível de Fermi e energia de gap em semicondutor dopado p.
//   ],
// )

//   #fonte[@fermi]

//   = Fontes do material, processo de obtenção e de manufatura

//   == Fontes do Material

//   Silício (Si) – O silício é o material semicondutor mais utilizado na fabricação de dispositivos eletrônicos, devido à sua abundância, custo acessível e propriedades favoráveis.

//     Fonte natural: O silício é extraído da areia, que é composta principalmente de dióxido de silício (SiO2).
//     Processo de obtenção: O silício é extraído da areia em um processo conhecido como redução carbônica, onde o SiO2 é aquecido com carbono para obter silício metálico.

//       #fonte[@james]

//   == Processo de Obtenção

//     Purificação do Silício:
//         O silício extraído da areia é purificado para obter silício de alta pureza (98% a 99% puro), utilizando técnicas como a redução de silício.
//         O processo mais comum de purificação é a redução do dióxido de silício com carbono, seguido pela refinação de Czochralski para produzir silício monocristalino.

//     Crescimento de Cristais:
//         Após a purificação, o silício é moldado em barras ou lingotes monocristalinos através do método de Czochralski, onde um cristal de silício é puxado lentamente para formar um lingote de silício.
//         Alternativamente, pode ser utilizado o processo float zone para formar cristais de alta pureza.

//     Corte do Cristal:
//         O lingote de silício é então cortado em waferes finos (fatias muito finas), utilizando serra diamantada ou outro processo de corte preciso.
//         Os waferes são polidos para garantir uma superfície lisa e adequada para a fabricação de dispositivos semicondutores.
//       #fonte[@james]
// == Processo de Manufatura de Semicondutores

// Dopagem:

//     A dopagem é o processo de adicionar impurezas (dopantes) ao silício para alterar suas propriedades elétricas.
//     Os dopantes mais comuns são o fósforo (P) e o boro (B), que criam regiões de tipo N (negativo) e tipo P (positivo), respectivamente, essenciais para a criação de diodos e transistores.

// Oxidação:

//     A oxidação do silício é realizada para formar uma camada de óxido de silício (SiO2) na superfície dos waferes. Esta camada serve como isolante e protetora durante os processos subsequentes de fabricação.

// Litografia:

//     A litografia é um processo essencial para criar padrões na superfície do wafer. Durante a litografia, uma camada de material fotossensível é aplicada no wafer, e a luz ultravioleta é usada para transferir um padrão da máscara para a superfície do wafer.
//       #fonte[@james]
// #pagebreak()
// Deposição de Filmes Finos:

//     Deposição de filmes finos pode ser realizada por técnicas como CVD (Chemical Vapor Deposition) ou PVD (Physical Vapor Deposition) para depositar camadas de materiais como metais, óxidos ou nitratos no wafer.

// Gravação (Etching):

//     O processo de gravação remove as áreas não desejadas dos materiais depositados ou da camada de óxido, utilizando produtos químicos ou plasmas.

// Densificação e Testes:

//     Após a fabricação dos dispositivos, a densificação do chip ocorre, onde o dispositivo é testado, cortado em formas pequenas (chips) e encapsulado.
//     Testes rigorosos de desempenho e funcionalidade são realizados para garantir a qualidade e a precisão.
//           #fonte[@james]

// = Técnicas de Caracterização

// == Medição de Resistividade Elétrica (Método de 4 Pontos)

// Descrição: O método de quatro pontos (ou técnica de Van der Pauw) é amplamente utilizado para medir a resistividade de materiais semicondutores. Consiste em aplicar uma corrente elétrica entre dois pontos de um material e medir a tensão nos outros dois pontos, de forma a obter a resistividade sem influenciar as medições com a resistência do contato.

// Aplicação: Esse método é utilizado para medir a resistividade de waferes de silício e outros materiais semicondutores.

// Equipamento: Medidores de resistividade de quatro pontos, como o Prober de 4 Pontos.

// == Método Hall

// Descrição: O efeito Hall é uma das técnicas mais comuns para determinar a mobilidade dos portadores de carga e a densidade de portadores em um material semicondutor. Consiste em aplicar um campo magnético perpendicular a um fluxo de corrente elétrica e medir a diferença de potencial (tensão de Hall) gerada perpendicularmente ao campo magnético.

// Aplicação: Determinação da condutividade elétrica de materiais semicondutores, como silício e germânio.

// Equipamento: Sistema de medição de efeito Hall, que inclui uma fonte de corrente, um campo magnético e um voltímetro.

// = Normas Técnicas Associadas

// == IEC 60747 - Semiconductor Devices

// Descrição: Esta norma da International Electrotechnical Commission (IEC) especifica os requisitos para dispositivos semicondutores, incluindo as características elétricas como a condutividade.

// Aplicação: Essa norma abrange os testes de caracterização elétrica dos dispositivos semicondutores, como os transistores, e pode incluir diretrizes sobre os métodos de medição da resistividade e da mobilidade de portadores.

// == ISO/IEC 17025 - Requisitos gerais para a competência de laboratórios de ensaio e calibração

// Descrição: Embora não seja específica para semicondutores, essa norma define os requisitos para a competência dos laboratórios de ensaio, incluindo aqueles que realizam medições de condutividade elétrica em materiais semicondutores.

// Aplicação: Ela assegura que os métodos de medição, como os testes de resistividade e mobilidade dos portadores, sejam realizados de forma confiável e repetível.

// == ASTM F1241 - Standard Test Method for Hall Effect Measurements

// Descrição: A ASTM F1241 especifica o método de medição do efeito Hall para determinar a mobilidade dos portadores de carga e a densidade de portadores em materiais semicondutores.

// Aplicação: Esta norma é importante para a caracterização de materiais semicondutores, como silício e arseneto de gálio, para dispositivos como transistores de efeito de campo (FETs).

// == ASTM D257 - Standard Test Methods for DC Resistance or Conductance of Insulating Materials

// Descrição: Esta norma descreve métodos para testar a resistência elétrica em materiais isolantes, que pode ser uma referência quando se estudam materiais semicondutores em dispositivos de isolamento.

// Aplicação: Pode ser útil para avaliar materiais usados em dispositivos semicondutores e em sistemas de isolamento elétrico.

// == JIS C 2550-3 - Semiconductor materials - Resistivity measurement

// Descrição: Norma japonesa que especifica os métodos para medir a resistividade de materiais semicondutores.

// Aplicação: Usada para definir os métodos de medição de resistividade de waferes de silício e outros materiais semicondutores, com foco em precisão e repetibilidade.



 = Bibliografia

 == Fontes
#set align(left + top)

#bibliography("refs.bib") 




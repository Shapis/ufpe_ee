#import "@preview/diatypst:0.3.0": *

#set text(lang: "pt")
#set cite(form: "full", style: "chicago-fullnotes")

#show: slides.with(
  title: "Fotocondutividade",
  subtitle: "Tecnologia dos Materiais 2024.2",
  date: "12.03.2025",
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

== Considerações Iniciais

Semicondutores possuem uma estrutura de bandas eletrônicas definida pelas propriedades cristalinas. A distribuição de energia dos elétrons é regida pelo nível de Fermi e a temperatura. A zero absoluto, todos os elétrons estão abaixo do nível de Fermi; em temperaturas maiores, seguem a distribuição de Fermi-Dirac.

#fonte[@wikicarriergen]

== Distribuição de Fermi-Dirac

#figure(
  image("fermi-dirac.png", width: 40%),
  caption: [
    Para um sistema de férmions idênticos em equilíbrio termodinâmico, o número médio de férmions em um estado de partícula única ii é dado pela distribuição de Fermi-Dirac (F-D). Onde $k_B$​ é a constante de Boltzmann, T é a temperatura absoluta, $ε_i$​ é a energia do estado de partícula única i e μ é o potencial químico total.
  ],
)

#fonte[@wikicarriergen]
 
 == Semicondutores Intrínsecos

 Em semicondutores não dopados, o nível de Fermi fica na lacuna entre a banda de valência (quase cheia) e a banda de condução (quase vazia). Elétrons na banda de valência não são móveis, impedindo a condução elétrica.

 #fonte[@wikicarriergen]

== Geração de portadores

 Se um elétron ganha energia suficiente, ele salta para a banda de condução, deixando uma lacuna que age como uma partícula carregada. A geração de portadores ocorre quando elétrons sobem de banda, e a recombinação acontece quando retornam, preenchendo lacunas.

 #fonte[@wikicarriergen]

== Relação entre geração e recombinação

Geração e recombinação ocorrem constantemente em semicondutores, tanto opticamente quanto termicamente. Em equilíbrio térmico, ambas se equilibram, mantendo a densidade de portadores constante. A ocupação dos estados de energia segue a estatística de Fermi-Dirac.

 #fonte[@wikicarriergen]

== O equilíbrio tende a ser mantido

O produto das densidades de elétrons e lacunas (n e p) é uma constante em equilíbrio($n_o p_o = n_i^2$​), mantida pela recombinação e geração em taxas iguais. Quando há um excesso de portadores ($n p > n_i^2$​), a taxa de recombinação supera a de geração, retornando o sistema ao equilíbrio. Da mesma forma, quando há um déficit de portadores ($n p < n_i^2$​), a geração excede a recombinação, restaurando o equilíbrio.

 #fonte[@wikicarriergen]

 == Geração de portadores

 Quando a luz interage com um material, ela pode ser absorvida (gerando um par de portadores livres ou um éxiton) ou pode estimular um evento de recombinação. O fóton gerado tem propriedades semelhantes ao que causou o evento. A absorção é o processo ativo em fotodiodos, células solares e outros fotodetectores semicondutores, enquanto a emissão estimulada é o princípio de funcionamento dos diodos laser.

Além da excitação por luz, portadores em semicondutores também podem ser gerados por um campo elétrico externo, como em LEDs e transistores.

Quando a luz com energia suficiente atinge um semicondutor, ela pode excitar elétrons através da banda proibida, gerando portadores adicionais e reduzindo temporariamente a resistência elétrica do material. Esse aumento da condutividade na presença de luz é chamado fotocondutividade.  

== Mecanismos de recombinação

A recombinação de portadores pode ocorrer através de múltiplos canais de relaxação. Os principais são a recombinação de banda a banda, a recombinação assistida por armadilhas Shockley–Read–Hall (SRH), a recombinação Auger e a recombinação de superfície. 

Esses canais de decaimento podem ser divididos em radiativos e não radiativos. Os não radiativos ocorrem quando a energia excessiva é convertida em calor pela emissão de fônons após o tempo de vida médio $tau_{n r}$.

Nos radiativos, pelo menos parte da energia é liberada na forma de emissão de luz ou luminescência após um tempo de vida radiativo $tau_{n r}$.

#fonte[@wikicarriergen]

#figure(
  image("recombinacao.png", width: 100%),
  caption: [
    O tempo de vida dos portadores $tau$ é obtido a partir da taxa de ambos os tipos de eventos.
  ],
)

#fonte[@wikicarriergen]

== Armadilha profunda ou radiativos

A distinção entre armadilhas rasas e profundas é baseada na proximidade das armadilhas de elétrons à banda de condução e das lacunas à banda de valência. Armadilhas rasas têm uma diferença menor que a energia térmica $k_B T$, enquanto armadilhas profundas têm uma diferença maior. Armadilhas rasas são mais fáceis de esvaziar e, por isso, costumam ser menos prejudiciais ao desempenho de dispositivos optoeletrônicos.


== Modelo SRH

No modelo SRH, quatro coisas podem acontecer envolvendo níveis de armadilha:

1. Um elétron na banda de condução pode ser aprisionado em um estado intrabanda.

2. Um elétron pode ser emitido na banda de condução a partir de um nível de armadilha.

3. Uma lacuna na banda de valência pode ser capturada por uma armadilha. Isso é análogo a uma armadilha preenchida liberando um elétron na banda de valência.
    
4. Uma lacuna capturada pode ser liberada na banda de valência, análoga à captura de um elétron da banda de valência.

#fonte[@wikicarriergen]

== Shockley–Read–Hall

#figure(
  image("shockley.png", width: 60%),
  caption: [
    Expressão de Shockley-Read-Hall para a recombinação assistida por armadilhas.
  ],
)

#fonte[@wikicarriergen]

== Recombinação Auger

Na recombinação Auger, a energia é transferida para um terceiro portador, excitando-o a um nível de energia mais alto sem mudar de banda. Após a interação, esse portador normalmente perde energia em vibrações térmicas. Esse processo, que envolve três partículas, é significativo apenas em condições de não equilíbrio, quando a densidade de portadores é alta. O efeito Auger não é facilmente produzido, pois a terceira partícula deve iniciar o processo em um estado instável de alta energia.

#fonte[@wikicarriergen]

== Equação de recombinação Auger

#figure(
  image("auger.png", width: 60%),
  caption: [
    O mecanismo que causa a queda da eficiência dos LEDs foi identificado em 2007 como recombinação Auger.
  ],
)



#fonte[@wikicarriergen]

== Recombinação de superfície

A recombinação assistida por armadilhas na superfície de um semicondutor é chamada de recombinação de superfície, ocorrendo devido a ligações não saturadas. É caracterizada pela velocidade de recombinação superficial, que depende da densidade de defeitos. Em células solares, pode ser o principal mecanismo de recombinação. Para minimizá-la, utilizam-se camadas de material transparente com larga banda proibida e técnicas de passivação.

#fonte[@wikicarriergen]

== Recombinação Langevin

A recombinação de superfície em semicondutores ocorre devido a ligações não saturadas e é caracterizada pela velocidade de recombinação superficial. Em células solares, pode ser o principal mecanismo de recombinação. Para minimizá-la, utilizam-se camadas transparentes com larga banda proibida e técnicas de passivação.

#fonte[@wikicarriergen]

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

== Diagrama do LDR (Light-Dependent Resistor)

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



 = Bibliografia

 == Fontes
#set align(left + top)

#bibliography("refs.bib") 




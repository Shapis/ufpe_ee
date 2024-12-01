#import "@preview/charged-ieee:0.1.3": ieee

#show: ieee.with(
  title: [Cristal Ideal e Propriedades Cristalinas],
  abstract: [
    Este trabalho aborda os conceitos fundamentais relacionados ao cristal ideal e suas propriedades estruturais. Explora-se o arranjo cristalino, destacando os componentes de base e rede, bem como as principais formas de organização atômica, como estruturas cúbicas simples, de corpo centrado (CCC) e de face centrada (CFC). Além disso, são discutidas as simetrias dos cristais, analisando os grupos matemáticos que descrevem rotações, reflexões e translações, e suas implicações nas propriedades anisotrópicas, piezoelétricas e ferroelétricas dos materiais. O estudo do cristal ideal serve como modelo teórico para compreender e prever o comportamento físico e químico de sólidos cristalinos na ciência dos materiais.
  ],
  authors: (
    (
      name: "Henrique da Silva",
      department: [Aluno de Tecnologia dos Materiais 2024.2],
      organization: [Universidade Federal de Pernambuco],
      location: [Recife, Brasil],
      email: "hpsilva@pm.me"
    ),
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

= Introdução
Os cristais ideais são modelos teóricos essenciais para compreender as propriedades dos materiais cristalinos. Com arranjos atômicos perfeitamente ordenados e periódicos, eles permitem estudar relações entre estrutura e propriedades, como anisotropia, piezoeletricidade e ferroeletricidade. Este trabalho apresenta os fundamentos do cristal ideal, abordando arranjo cristalino, simetrias e suas implicações na ciência dos materiais.

= Motivação

O estudo dos cristais ideais é fundamental para entender como a organização atômica influencia as propriedades dos materiais. Esses modelos teóricos permitem analisar estruturas cristalinas perfeitas, destacando suas simetrias e arranjos periódicos. A compreensão dessas características é crucial para prever o comportamento de sólidos cristalinos e desenvolver materiais avançados com propriedades específicas, como alta condutividade elétrica, resistência mecânica ou funcionalidades piezoelétricas, amplamente aplicados em tecnologia, ciência e engenharia.

= Intuição Física

A intuição física por trás dos cristais ideais está na relação direta entre sua estrutura perfeitamente ordenada e as propriedades macroscópicas dos materiais. A periodicidade atômica implica regularidade em como os átomos interagem, resultando em características únicas, como anisotropia (variação de propriedades conforme a direção), formação de bandas eletrônicas e comportamentos térmicos previsíveis.

Por exemplo, em cristais metálicos, a rede cristalina influencia a mobilidade dos elétrons de condução, determinando a condutividade elétrica. Já em cristais piezoelétricos, a simetria estrutural permite que deformações mecânicas gerem cargas elétricas. Assim, os conceitos de cristal ideal servem como uma base para visualizar como interações microscópicas governam fenômenos físicos observáveis, proporcionando insights essenciais para o design e o entendimento de novos materiais.

= Contexto Histórico

== 1611 Johannes Kepler

Em 1611, Johannes Kepler escreveu o tratado Sobre o Floco de Neve de Seis Pontas @kepler, onde se perguntava por que os cristais de neve sempre têm seis lados. Mesmo sem saber sobre átomos, ele imaginou que a forma dos cristais poderia ter algo a ver com a disposição hexagonal das partículas. Kepler reconheceu que essa simetria era uma questão interessante, mas não tinha como respondê-la na época.

== 1634 René Descartes 

René Descartes foi o primeiro a fazer uma descrição detalhada dos cristais de neve, observando-os a olho nu. Ele notou formas raras, como colunas com tampas e flocos de neve com 12 lados @descartes. Embora suas observações fossem limitadas pela tecnologia da época, elas foram importantes e ajudaram a iniciar estudos mais avançados sobre os cristais de neve.

== 1665 Robert Hooke

Em 1665, Robert Hooke publicou @hooke, um livro com suas observações feitas com o microscópio. Entre os desenhos, estavam os primeiros esboços detalhados de cristais de neve, que mostraram pela primeira vez a complexidade e simetria das suas formas. Essas ilustrações ajudaram a entender melhor como os cristais de neve se formam e deram início a novas descobertas no estudo dos cristais.

== 1925 Wilson Bentley

Wilson Bentley (1865-1931) foi um fazendeiro americano apaixonado por cristais de neve e um dos primeiros a fotografá-los. Durante sua vida, ele capturou cerca de 5.000 imagens desses cristais, e mais de 2.000 delas foram publicadas em seu livro Snow Crystals, lançado em 1931. Seu trabalho ajudou a mostrar a beleza e a complexidade dos cristais de neve, usando a fotografia microscópica para registrá-los. Até hoje, algumas dessas imagens podem ser vistas no site oficial de Bentley, mantendo vivo seu legado e sua contribuição para a ciência e a arte.

== 1954 Ukichiro Nakaya

Ukichiro Nakaya foi o primeiro a realizar um estudo sistemático sobre os cristais de neve, dando um grande passo na compreensão de como eles se formam. Inicialmente treinado como físico nuclear, Nakaya foi professor em Hokkaido, Japão, em 1932, onde não havia recursos para sua área. Então, ele se dedicou ao estudo dos cristais de neve, abundantes na região, e fez detalhadas observações de todos os tipos de precipitação congelada, catalogando as formas mais comuns.

Diferente de Bentley, que focou apenas nos cristais mais bonitos e simétricos, Nakaya documentou a variedade de formas. Seu grande avanço foi conseguir criar cristais de neve artificiais em laboratório, sob condições controladas. Isso lhe permitiu entender melhor como as condições ambientais afetam a formação dos cristais.

Seu trabalho foi publicado em 1954 no livro Snow Crystals: Natural and Artificial @nakaya.

= Fundamentação Geométrica e Matemática

== Célula unitária e modelo de esfera rígida


A célula unitaria é a unidade básica repetitiva de um cristal, representando a menor estrutura que, quando repetida em todas as direções, forma o cristal completo. Ela define as propriedades do cristal, como sua simetria e estrutura.


#figure(
  image("modelo_esfera_rigida.png", width: 80%),
  caption: [
   Célula unitária e modelo de esfera rígida. @callister
  ],
)
 <fig:modelo_esfera_rigida>

O modelo de esfera rígida é uma aproximação usada para descrever como as partículas (átomos, íons ou moléculas) se organizam em um cristal. Nesse modelo, as partículas são tratadas como esferas que não se deformam, ocupando os espaços disponíveis de forma regular e eficiente, como no empacotamento cúbico ou hexagonal. @youtube

 == Cúbica de Face Centrada (CFC)

O CFC (Cúbica de Face Centrada) é um tipo de arranjo cristalino onde as partículas (átomos, íons ou moléculas) estão dispostas em um padrão cúbico, com um átomo no centro de cada face do cubo e um na origem de cada vértice. Esse tipo de estrutura é muito comum em metais, como o alumínio, cobre e ouro, e tem alta densidade de empacotamento, o que significa que as partículas ocupam a maior parte do espaço disponível. O CFC é caracterizado por uma alta simetria e suas propriedades incluem boa ductilidade e resistência ao escorrimento, facilitando a deformação plástica do material. @youtube

 == Cúbica de Corpo Centrado (CCC)

 O CCC (Cúbica de Corpo Centrado) é um tipo de arranjo cristalino onde as partículas estão dispostas em um padrão cúbico, com um átomo no centro do cubo e um átomo em cada um dos oito vértices do cubo. Esse arranjo é característico de metais como ferro (em sua forma alfa), cromo e tungstênio. O empacotamento no CCC não é tão eficiente quanto no CFC, resultando em uma densidade de empacotamento menor. No entanto, o CCC apresenta boa resistência mecânica e é frequentemente encontrado em materiais que precisam suportar altas tensões e temperaturas. Além disso, os cristais no CCC têm uma estrutura que permite uma certa flexibilidade, mas menos ductilidade em comparação com arranjos como o CFC. @youtube

 == Cúbica Simples (CS)

 O CS (Cúbica Simples) é um tipo de arranjo cristalino onde as partículas estão dispostas de maneira simples em um padrão cúbico, com um átomo em cada vértice do cubo e nenhum átomo no centro da célula unitária. Esse arranjo é o menos eficiente em termos de empacotamento, ocupando apenas cerca de 52% do volume disponível, o que o torna menos denso em comparação com outras estruturas, como a CFC ou CCC. O CS é encontrado em metais como o sódio e o potássio, que têm propriedades mecânicas relativamente mais fracas e são mais suscetíveis à deformação. Embora a estrutura cúbica simples seja relativamente rara em materiais metálicos, ela pode ser observada em alguns elementos químicos em condições específicas.

= Simetrias do Cristal

== Grupos Matemáticos de Simetria

As simetrias dos cristais referem-se às transformações geométricas que podem ser aplicadas a uma célula unitária sem alterar a estrutura do cristal. Essas simetrias são fundamentais para entender as propriedades e o comportamento dos cristais, como suas formas e suas interações com a luz.

Os *grupos matemáticos de simetria* são usados para classificar as simetrias dos cristais. Esses grupos descrevem as operações que podem ser realizadas em um cristal, como rotações, reflexões e translações, sem modificar sua aparência. Existem dois tipos principais de grupos de simetria usados em cristalografia:

1. *Grupos Pontuais*: Envolvem simetrias que não alteram a posição de um ponto no espaço. Isso inclui operações como rotação, reflexão e inversão. Por exemplo, a rotação de 90° ao redor de um eixo ou a reflexão em um plano.

2. *Grupos Espaciais*: Incluem as simetrias dos grupos pontuais, mas também consideram as translações no espaço, o que significa que o cristal pode ser movido sem alterar sua estrutura. Esses grupos são mais complexos e podem descrever padrões de repetição infinita em todas as direções.

Esses grupos matemáticos ajudam a determinar as propriedades físicas dos cristais, como suas propriedades ópticas, mecânicas e térmicas, e são essenciais para entender a estrutura e o comportamento dos materiais cristalinos. @callister


== Propriedades Associadas à Simetria

As *propriedades associadas à simetria* dos cristais são fundamentais para determinar como um cristal interage com o ambiente e quais características ele possui. A simetria de um cristal, que é determinada pela repetição e arranjo das unidades atômicas, afeta diretamente suas propriedades físicas, químicas e mecânicas. Algumas das principais propriedades relacionadas à simetria incluem:

1. *Anisotropia*: Refere-se à variação das propriedades de um cristal com base na direção. Em cristais com simetrias mais simples ou com menos simetrias, as propriedades, como dureza, condutividade elétrica e óptica, podem ser diferentes dependendo da direção. Por outro lado, cristais altamente simétricos tendem a ser isotrópicos, ou seja, suas propriedades são as mesmas em todas as direções.

2. *Piezoeletricidade*: Alguns cristais geram uma carga elétrica quando são comprimidos ou deformados. Essa propriedade é associada à simetria do cristal; cristais que não possuem um centro de simetria podem exibir piezoeletricidade, como o quartzo, sendo muito utilizado em dispositivos como sensores e alto-falantes.

3. *Ferroeletricidade*: Semelhante à piezoeletricidade, mas com a diferença de que cristais ferroelétricos têm uma polarização espontânea, ou seja, eles possuem uma orientação elétrica interna que pode ser invertida por um campo elétrico. Essa propriedade está ligada a simetrias específicas e é encontrada em materiais como o titanato de bário.

4. *Óptica não linear*: Cristais com simetrias especiais podem modificar a luz de maneiras não lineares, como dobrar a frequência da luz ou gerar novas cores quando expostos a intensidades de luz muito altas. Essa propriedade é crucial para tecnologias como lasers e dispositivos ópticos avançados.

Essas propriedades destacam como a simetria interna de um cristal é essencial para determinar suas características e comportamento em diversas aplicações tecnológicas e científicas. A análise das simetrias cristalinas é, portanto, uma ferramenta importante para prever e entender as propriedades dos materiais. @callister

= Manufatura

A *evaporação* é um dos métodos mais simples para manufaturar cristais. Neste processo, uma solução saturada da substância desejada (como sal ou açúcar) é preparada dissolvendo o material em um solvente, geralmente água. A solução é então aquecida, fazendo com que o solvente evapore lentamente. À medida que a água evapora, a concentração da substância aumenta, e os cristais começam a se formar à medida que o material se precipita. Esse processo é ideal para obter cristais de tamanho relativamente grande e bem formados, especialmente em ambientes controlados para evitar contaminações. @crystalverse

= Caracterização e Normas


- ISO 9001:2015 (Gestão da Qualidade)
Um padrão internacional que define requisitos para a implementação de um sistema de gestão da qualidade eficaz. Ele é usado para garantir consistência, melhorar processos e aumentar a satisfação do cliente em organizações de diversos setores.

- ASTM E1941-18 (Guias para Materiais Cristalinos)
Um guia técnico publicado pela ASTM que aborda práticas e métodos padronizados para a caracterização de materiais cristalinos. Inclui recomendações para medições, análises e validação de propriedades cristalográficas.

- ISO 17274:2016 (Determinando a Estrutura Cristalina)
Especifica métodos para determinar a estrutura cristalina de materiais utilizando técnicas como difração de raios X. É aplicado na análise de materiais para fins de pesquisa e controle de qualidade.

= Aplicações

Os cristais têm diversas aplicações em várias áreas devido às suas propriedades únicas. Na eletrônica, são usados em semicondutores, diodos, transistores e LEDs. Na óptica, cristais são empregados em lentes, prismas e dispositivos fotônicos. Na medicina, cristais piezoelétricos são usados em ultrassons e marcapassos. Na tecnologia de materiais, cristais como diamantes são usados em ferramentas e abrasivos. Além disso, cristais de silício são fundamentais em painéis solares e baterias. Cristais também têm aplicações em joias, indústria química e pesquisas minerais, demonstrando sua importância em várias indústrias. 

A *aplicação de cristais em semicondutores* é fundamental para a eletrônica moderna. Cristais de *silício* e *germânio* são usados como materiais semicondutores, que podem conduzir eletricidade sob certas condições. A dopagem desses cristais com impurezas específicas cria *junções P-N*, essenciais para o funcionamento de dispositivos como *transistores*, *diodos*, *circuitos integrados* e *chips de computador*. Essas junções controlam o fluxo de corrente elétrica, permitindo a criação de componentes eletrônicos que formam a base de praticamente todos os dispositivos eletrônicos modernos, como computadores, smartphones e sistemas de comunicação @semicon. 



/*#figure(
  caption: [The Planets of the Solar System and Their Average Distance from the Sun],
  placement: top,
  table(
    // Table styling is not mandated by the IEEE. Feel free to adjust these
    // settings and potentially move them into a set rule.
    columns: (6em, auto),
    align: (left, right),
    inset: (x: 8pt, y: 4pt),
    stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
    fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0  { rgb("#efefef") },

    table.header[Planet][Distance (million km)],
    [Mercury], [57.9],
    [Venus], [108.2],
    [Earth], [149.6],
    [Mars], [227.9],
    [Jupiter], [778.6],
    [Saturn], [1,433.5],
    [Uranus], [2,872.5],
    [Neptune], [4,495.1],
  )
) <tab:planets>



#lorem(240)

#lorem(240)
*/
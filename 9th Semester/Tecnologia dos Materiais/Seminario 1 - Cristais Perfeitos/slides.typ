#import "@preview/diatypst:0.3.0": *

#set text(lang: "pt")
#set cite(form: "full", style: "chicago-fullnotes")

#show: slides.with(
  title: "Cristal Ideal e Propriedades Cristalinas",
  subtitle: "Tecnologia dos Materiais 2024.2",
  date: "01.12.2024",
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

= Contexto Histórico 

== Johannes Kepler

#quote(attribution: [Kepler, 1611])[
  Each single plant has a single animating principle of its own, since each instance of a pl"medium",
  title-color: blue.darken(60%),
  toc: true,
  count: false,urd, and therefore the shapes of snowflakes are by no means to be deduced from the operation of soul in the same way as with plants.
]

#fonte[@kepler]

== René Descartes

#quote(attribution: [René Descartes, 1635])[
  I only had difficulty to imagine what could have formed and made so exactly symmetrical these six teeth around each grain in the midst of free air and during the agitation of a very strong wind, until I finally considered that this wind had easily been able to carry some of these grains to the bottom or to the top of some cloud, and hold them there, because they were rather small; and that there they were obliged to arrange themselves in such a way that each was surrounded by six others in the same plane, following the ordinary order of nature.
]

#fonte[@descartes]

== Robert Hooke

#quote(attribution: [Robert Hooke, 1665])[
  By  the help of microscopes, there is nothing so small, as to escape our inquiry; hence there's a new visible world discovered to the understanding.
]

#fonte[@hooke]

==   Wilson Bentley 

#quote(attribution: [Wilson Bentley, 1925])[  
Under the microscope, I found that snowflakes were miracles of beauty; and it seemed a shame that this beauty should not be seen and appreciated by others. Every crystal was a masterpiece of design and no one design was ever repeated. When a snowflake melted, that design was forever lost. Just that much beauty was gone, without leaving any record behind.
]

#fonte["Eu vi em um sonho"]

==   Ukichiro Nakaya


#quote(attribution: [Ukichiro Nakaya, 1954])[  
A snow crystal is a letter from the sky.
]

#fonte[@nakaya]

= Introdução ao Cristal Ideal

== Cristal Ideal

Um cristal ideal é uma estrutura geométrica composta por átomos, íons ou moléculas organizados de maneira periódica e repetitiva no espaço.  
Propriedades principais:
- *Perfeição geométrica*
- *Ausência de defeitos estruturais*
- *Modelo idealizado para estudos teóricos*

#fonte[@callister]

== Exemplos de Materiais Cristalinos

- Metais: Cobre, Alumínio  
- Semicondutores: Silício, Germânio  
- Minerais: Quartzo, Diamante

#fonte[@callister]

= Arranjo Cristalino

== Base e Rede

O arranjo cristalino é composto por:
1. *Base*: Grupo de átomos que se repetem.
2. *Rede Cristalina*: Estrutura geométrica abstrata de pontos no espaço.

Exemplos de redes:  
- *Cúbica de corpo centrado (CCC)*  
- *Cúbica de face centrada (CFC)*
- *Cúbica simples (CS)*

#fonte[@callister]

#fonte[@yt_aula10]

== Modelo de esfera rígida e célula unitária

#figure(
  image("modelo_esfera_rigida.png", width: 100%),
  caption: [
    Modelo de esfera rígida e célula unitária.
  ],
)
 <fig:modelo_esfera_rigida>
 

== Cubica de Faces Centradas (CFC)
 
#figure(
  image("cfc1.png", width: 100%),
  caption: [
    Cálculo de parâmetro de rede CFC.
  ],
)
 <fig:cfc1>

 #figure(
  image("cfc2.png", width: 100%),
  caption: [
    Cálculo de número de átomos, FEA e número de coordenação.
  ],
)
 <fig:cfc2>

 == Cúbica de Corpo Centrado. (CCC)

 #figure(
  image("ccc1.png", width: 100%),
  caption: [
    Cálculo de parâmetro de rede CCC.
  ],
)
 <fig:ccc1>

 #figure(
  image("ccc2.png", width: 100%),
  caption: [
    Cálculo de parâmetro de rede CCC.
  ],
)
 <fig:ccc2>

 #figure(
  image("ccc3.png", width: 100%),
  caption: [
    Cálculo de número de átomos, FEA e número de coordenação.
  ],
)
 <fig:ccc3>

 == Cúbica Cristalina Simples (CS).

  #figure(
  image("cs1.png", width: 80%),
  caption: [
    Cálculo de parâmetro de rede CS.
  ],
)
 <fig:ccc1>


  #figure(
  image("massa_especifica1.png", width: 100%),
  caption: [
    Cálculo da massa específica.
  ],
)
 <fig:massa_especifica1>

   #figure(
  image("massa_especifica2.png", width: 100%),
  caption: [
    Cálculo da massa específica do cobre.
  ],
)
 <fig:massa_especifica2>

   #figure(
  image("massa_especifica3.png", width: 100%),
  caption: [
    Cálculo da massa específica do cobre.
  ],
)
 <fig:massa_especifica3>


== Propriedades do Arranjo

- *Regularidade no espaço tridimensional*  
- *Definem propriedades mecânicas, ópticas e térmicas do material*  
- *Influenciam a densidade do material*

#fonte[@callister]

= Simetrias do Cristal

== Grupos Matemáticos de Simetria

Os cristais podem ser classificados com base em sua simetria:
- *Grupos pontuais*: Rotação, reflexão e inversão.  
- *Grupos espaciais*: Combinação de translações e simetrias pontuais.


#fonte[@callister]

#fonte[@yt_aula12]

== Propriedades Associadas à Simetria

1. *Anisotropia*: Propriedades variam com a direção.
2. *Piezoeletricidade*: Geração de carga elétrica por deformação.
3. *Ferroeletricidade*: Polarização espontânea reversível.

O conhecimento das simetrias ajuda a prever propriedades físicas e químicas dos cristais.

#fonte[@callister]

#fonte[@yt_aula12]

== Pontos Cristalográficos

   #figure(
  image("pontos_cristalograficos1.png", width: 100%),
)
 <fig:pontos_cristalograficos1>

    #figure(
  image("pontos_cristalograficos2.png", width: 100%),
)
 <fig:pontos_cristalograficos2>

     #figure(
  image("pontos_cristalograficos3.png", width: 100%),
)
 <fig:pontos_cristalograficos3>

      #figure(
  image("pontos_cristalograficos4.png", width: 100%),
)
 <fig:pontos_cristalograficos4>

       #figure(
  image("pontos_cristalograficos5.png", width: 100%),
)
 <fig:pontos_cristalograficos5>

 == Direções Cristalográficas.

        #figure(
  image("direcoes_cristalograficas1.png", width: 100%),
)
 <fig:direcoes_cristalograficas1>

         #figure(
  image("direcoes_cristalograficas2.png", width: 100%),
)
 <fig:direcoes_cristalograficas2>

        #figure(
  image("direcoes_cristalograficas3.png", width: 100%),
)
 <fig:direcoes_cristalograficas3>

== Planos Cristalográficos

        #figure(
  image("planos_cristalograficos1.png", width: 100%),
)
 <fig:planos_cristalograficos1>

         #figure(
  image("planos_cristalograficos2.png", width: 100%),
)
 <fig:planos_cristalograficos2>

         #figure(
  image("planos_cristalograficos3.png", width: 100%),
)
 <fig:planos_cristalograficos3>

         #figure(
  image("planos_cristalograficos4.png", width: 100%),
)
 <fig:planos_cristalograficos4>

 == Densidade Linear e Planar

         #figure(
  image("densidade1.png", width: 100%),
)
 <fig:densidade1>

          #figure(
  image("densidade2.png", width: 100%),
)
 <fig:densidade2>


          #figure(
  image("densidade3.png", width: 100%),
)
 <fig:densidade3>

== Policristais

          #figure(
  image("policristais1.png", width: 100%),
)
 <fig:policristais1>

           #figure(
  image("policristais2.png", width: 100%),
)
 <fig:policristais2>

            #figure(
  image("policristais3.png", width: 100%),
)
 <fig:policristais3>


= Manufatura

== Criando Um Cristal de Sal

  #figure(
  image("salt_crystal.jpg", width: 100%),
  caption: [
    Cristal de cloreto de sódio.
  ],
)
 <fig:crystal0>

   #figure(
  image("salt1.jpg", width: 100%),
  caption: [
    Criando a solução.
  ],
)
 <fig:crystal1>

    #figure(
  image("salt2.jpg", width: 100%),
  caption: [
    Solução criada.
  ],
)
 <fig:crystal2>

     #figure(
  image("salt3.jpg", width: 100%),
  caption: [
    Gerando uma semente.
  ],
)
 <fig:crystal3>

 #figure(
  image("salt4.jpg", width: 100%),
  caption: [
    Sementes formadas.
  ],
)
 <fig:crystal4>

  #figure(
  image("salt5.jpg", width: 100%),
  caption: [
    Gerando cristais a partir das sementes.
  ],
)
 <fig:crystal5>

 #figure(
  image("salt6.jpg", width: 100%),
  caption: [
    Cristais formados.
  ],
)
 <fig:crystal6>

 = Normas

== Códigos das Normas

    - ISO 9001:2015 (Gestão da Qualidade)
    Um padrão internacional que define requisitos para a implementação de um sistema de gestão da qualidade eficaz. Ele é usado para garantir consistência, melhorar processos e aumentar a satisfação do cliente em organizações de diversos setores.

    - ASTM E1941-18 (Guias para Materiais Cristalinos)
    Um guia técnico publicado pela ASTM que aborda práticas e métodos padronizados para a caracterização de materiais cristalinos. Inclui recomendações para medições, análises e validação de propriedades cristalográficas.

    - ISO 17274:2016 (Determinando a Estrutura Cristalina)
    Especifica métodos para determinar a estrutura cristalina de materiais utilizando técnicas como difração de raios X. É aplicado na análise de materiais para fins de pesquisa e controle de qualidade.

 = Aplicações

 == Marcapasso

  #figure(
  image("marcapasso.jpg", width: 100%),
  caption: [
    Utiliza-se a propriedade da piezoeletricidade na manufatura de marcapassos. 
  ],
)

== Lasers

  #figure(
  image("lasers.png", width: 100%),
  caption: [
    Láseres são outro exemplo que utilizam propriedades de cristais para serem fabricados.
  ],
)

 == Semicondutores

 #figure(
  image("silicon_doping.svg", width: 100%),
  caption: [
    Exemplo de dopagem de semicondutores.
  ],
)
 <fig:crystal6>

 = Bibliografia

 == Fontes
#set align(left + top)

#bibliography("refs.bib") 




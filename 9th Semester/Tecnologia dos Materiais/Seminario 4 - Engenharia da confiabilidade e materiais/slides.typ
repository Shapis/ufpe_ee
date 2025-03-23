#import "@preview/diatypst:0.3.0": *

#set text(lang: "pt")
#set cite(form: "full", style: "chicago-fullnotes")

#show: slides.with(
  title: "Engenharia da confiabilidade e materiais",
  subtitle: "Tecnologia dos Materiais 2024.2",
  date: "22.03.2025",
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

A Engenharia da Confiabilidade tem como objetivo garantir o desempenho seguro e eficiente de sistemas e componentes ao longo do tempo. No contexto industrial, a escolha e o comportamento dos materiais são fatores críticos para evitar falhas e otimizar a vida útil dos produtos. O estudo da degradação, ensaios mecânicos e técnicas preditivas são fundamentais para melhorar a confiabilidade dos materiais aplicados em diversos setores.

== Motivação

A crescente demanda por produtos mais duráveis e eficientes exige um aprofundamento no estudo da confiabilidade dos materiais. Compreender os mecanismos de falha, prever desgastes e aplicar metodologias adequadas reduz custos de manutenção, melhora a segurança operacional e impulsiona a inovação. Esse seminário visa discutir abordagens e técnicas para aprimorar a confiabilidade dos materiais, contribuindo para o desenvolvimento de soluções industriais mais seguras e eficientes.

= Intuição Física

== Compreendendo Falhas e Desempenho ao Longo do Tempo

A engenharia da confiabilidade aplicada aos materiais busca entender e prever como e por que falhas ocorrem em componentes ao longo do tempo. A intuição física por trás desse problema está relacionada às respostas dos materiais a esforços mecânicos, térmicos e químicos.

== Mecanismos de Degradação e Confiabilidade Estrutural dos Materiais

Os materiais, ao serem submetidos a cargas externas, sofrem deformações e podem acumular danos microscópicos, que eventualmente levam à falha estrutural. Fatores como fadiga, corrosão, fluência e impacto influenciam diretamente a durabilidade e a segurança dos componentes. A confiabilidade, portanto, depende de um equilíbrio entre as propriedades do material, as condições operacionais e os mecanismos de degradação.

== Previsão de Falhas e Otimização do Desempenho de Materiais em Sistemas Complexos

Dessa forma, estudar a confiabilidade dos materiais permite prever falhas antes que ocorram, minimizando riscos e otimizando o desempenho de sistemas complexos, desde turbinas aeronáuticas até componentes eletrônicos.


= Experimento de Fadiga por August Wöhler (Século XIX)

== Contexto Histórico

Durante a Segunda Guerra Mundial, engenheiros começaram a observar falhas inesperadas nas asas de aeronaves, mesmo quando operavam dentro dos limites de carga especificados. Essas falhas ocorriam devido à fadiga do material, um fenômeno pouco compreendido na época.

== O Caso da Quebra das Asas de Aviões da Segunda Guerra Mundial

Antes mesmo da guerra, no século XIX, o engenheiro alemão August Wöhler conduziu experimentos pioneiros para estudar a resistência dos materiais submetidos a cargas cíclicas. Ele criou a curva S-N (Tensão vs. Número de ciclos até a falha), que demonstrava como materiais aparentemente resistentes poderiam falhar após repetidos ciclos de carga abaixo do limite de resistência estática.

#fonte[@curva_sn]

== Curva S-N

#figure(
  image("curva_sn.png", width: 35%),
  caption: [
    Curva S-N de um material metálico, mostrando a relação entre a tensão aplicada e o número de ciclos até a falha.
  ],
)

#fonte[@curva_sn]

== Aplicação na Aviação

Durante a Segunda Guerra, o conceito de fadiga foi revisitado por engenheiros aeronáuticos após falhas inesperadas em aeronaves como o P-51 Mustang e o B-24 Liberator. Os experimentos inspirados no trabalho de Wöhler levaram ao desenvolvimento de testes sistemáticos para prever a vida útil dos materiais sob cargas cíclicas, permitindo aprimorar a confiabilidade das estruturas aeronáuticas.

== Impacto

Esse estudo revolucionou a engenharia da confiabilidade aplicada aos materiais, estabelecendo práticas modernas de ensaios de fadiga e garantindo que componentes críticos fossem projetados para resistir a longos períodos de uso sem falha inesperada. A partir desses experimentos, a engenharia passou a considerar a fadiga como um dos principais fatores na análise da confiabilidade estrutural.

= Formalismo Matemático

== Distribuição Exponencial 


#figure(
  image("dist_expo.png", width: 100%),
)

#fonte[@reliability]

== Distribuição Weibull

#figure(
  image("weibul.png", width: 100%),
)

#fonte[@reliability]

== Função de Confiabilidade

#figure(
  image("func_conf.png", width: 100%),
)

#fonte[@reliability]

==  Taxa de Falha ($lambda$(t))

#figure(
  image("taxa_falha.png", width: 100%),
)

#fonte[@reliability]

== Taxa de Falha 

#figure(
  image("taxa_falha2.png", width: 60%),
)

#fonte[@reliability]

== Tempo Médio Até a Falha (MTTF - Mean Time to Failure)

#figure(
  image("MTTF.png", width: 60%),
)

#fonte[@reliability]

== Função de Disponibilidade (A(t))

#figure(
  image("disponibilidade.png", width: 80%),
)

#fonte[@reliability]

== Modelo de Fadiga - Curva S-N (Wöhler)

#figure(
  image("wohler.png", width: 50%),
)

#fonte[@reliability]

== Modelo de Fadiga - Curva S-N (Wöhler)

#figure(
  image("curva_sn.png", width: 40%),
)

#fonte[@reliability]

=  Equipamentos e Técnicas de Caracterização

== Caracterização Microestrutural

- Microscopia Eletrônica de Varredura (SEM - Scanning Electron Microscopy)

- Microscopia Eletrônica de Transmissão (TEM - Transmission Electron Microscopy)

- Microscopia Óptica (OM - Optical Microscopy)

- Difração de Raios X (XRD - X-Ray Diffraction)

== Caracterização Mecânica

- Ensaio de Dureza (Brinell, Rockwell, Vickers, Knoop)

- Ensaio de Tração

- Ensaio de Impacto (Charpy e Izod)

- Ensaio de Fadiga

- Ensaio de Fluência

== Caracterização Térmica

- Análise Termogravimétrica (TGA - Thermogravimetric Analysis)

- Calorimetria Exploratória Diferencial (DSC - Differential Scanning Calorimetry)

- Análise Dinâmico-Mecânica (DMA - Dynamic Mechanical Analysis)

== Caracterização Química

- Espectroscopia de Infravermelho (FTIR - Fourier Transform Infrared Spectroscopy)

- Espectroscopia de Fluorescência de Raios X (XRF - X-Ray Fluorescence Spectroscopy)

- Espectrometria de Massa (MS - Mass Spectrometry)

== Ensaios Não Destrutivos (NDT - Non-Destructive Testing)

- Ultrassom (UT - Ultrasonic Testing)

- Radiografia Industrial (Raio-X e Gama)

- Partículas Magnéticas (MT - Magnetic Particle Testing)

- Líquidos Penetrantes (PT - Penetrant Testing)

= Normas

== Normas Gerais de Confiabilidade

- ISO 31010 – Gestão de Riscos e Métodos de Avaliação

Apresenta metodologias para identificação e análise de riscos em engenharia de confiabilidade.

- IEC 60300 – Dependability Management

Série de normas da Comissão Eletrotécnica Internacional (IEC) que cobre princípios gerais de confiabilidade.

- MIL-HDBK-217 – Reliability Prediction of Electronic Equipment

Manual do Departamento de Defesa dos EUA para prever a confiabilidade de equipamentos eletrônicos.

== Normas para Ensaios Mecânicos e Caracterização de Materiais

- ASTM E8 / E8M – Ensaio de Tração em Materiais Metálicos

Define métodos para medir resistência à tração, escoamento e alongamento de metais.

- ASTM E23 – Ensaio de Impacto Charpy

Padroniza testes de impacto para medir tenacidade de materiais.

- ASTM E466 – Ensaio de Fadiga

Especifica procedimentos para ensaios de resistência à fadiga em materiais metálicos.

- ISO 6507 – Dureza Vickers

Padroniza medições de dureza usando o método Vickers.

- ISO 6508 – Dureza Rockwell

Define os procedimentos para medição de dureza pelo método Rockwell.

== 3. Normas para Ensaios Não Destrutivos (NDT - Non-Destructive Testing)

- ISO 9712 – Qualificação e Certificação de Pessoal em Ensaios Não Destrutivos

- ASTM E1444 – Ensaio de Partículas Magnéticas


- ASTM E165 – Ensaio de Líquidos Penetrantes

- ASTM E213 – Teste Ultrassônico para Tubos Metálicos

- IEC 60068 – Testes Ambientais em Componentes Eletrônicos


== Normas para Ensaios de Degradação e Análise de Vida Útil

- ASTM G154 – Ensaio de Envelhecimento Acelerado por UV

Define procedimentos para testes de degradação de polímeros e revestimentos por exposição a radiação UV.

- ASTM G31 – Corrosão por Imersão em Meio Aquoso

Normativa para avaliação da corrosão de materiais em soluções líquidas.

- ISO 9227 – Teste de Névoa Salina

Padrão para ensaios de resistência à corrosão em metais e revestimentos.

- IEC 60068 – Testes Ambientais em Componentes Eletrônicos

Série de normas que definem testes climáticos e mecânicos para componentes eletrônicos.

= Aplicações

== Confiabilidade em Sistemas Eletrônicos

- Predição de vida útil de componentes eletrônicos (capacitores, resistores, transistores, microprocessadores).

- Análise de falha em circuitos impressos (PCBs) devido a fadiga térmica e ciclos de carga.

- Uso do MIL-HDBK-217 para prever falhas e aumentar a confiabilidade de sistemas eletrônicos.

#fonte[@reliability]

== Confiabilidade em Redes de Distribuição e Transmissão

- Monitoramento da degradação de isoladores elétricos devido a poluição e descargas elétricas.

- Modelagem da falha de transformadores usando análise de óleo isolante para prever falhas internas.

- Uso de ensaios térmicos (TGA e DSC) para avaliar a degradação de materiais dielétricos.

== Análise de Degradação em Baterias e Dispositivos de Armazenamento

- Análise de ciclos de carga e descarga em baterias de íon-lítio usadas em sistemas fotovoltaicos.

- Modelagem da degradação exponencial para prever a perda de capacidade ao longo do tempo.



= Bibliografia

== Fontes
#set align(left + top)

#bibliography("refs.bib") 




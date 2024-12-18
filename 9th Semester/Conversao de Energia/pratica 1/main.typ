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

#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"
#include "chapters/chapter4.typ"
#include "chapters/chapter5.typ"

// #pagebreak()
// #bibliography("refs.bib")
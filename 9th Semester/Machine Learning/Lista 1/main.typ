#import "relatorio_padrao.typ"

// #set cite(form: "full", style: "chicago-fullnotes")
// #set align(start + top)

#show: relatorio_padrao.project.with(
  title: "Aprendizagem de Máquina (ES456/2023-1)",
  subtitle: "Primeira Lista de Exercícios",
  authors: (
    "Henrique Pedro da Silva",
  ),
  school-logo: image("images/Brasao_da_UFPE.png"), // Replace with [] to remove the school logo
  // company-logo: image("images/company.svg"),
  mentors: (
    "Dr. Daniel de Filgueiras Gomes", 
  ),
  branch: "Departamento de Eletrônica e Sistemas",
  academic-year: "2024.2",
  footer-text: "UFPE", // Text used in left side of the footer
  repo: "https://github.com/Shapis/ufpe_ee",
)

// Put then your content here

#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"
#include "chapters/chapter4.typ"

// #pagebreak()
// #bibliography("refs.bib")
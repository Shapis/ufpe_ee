#let epigraph(quote, authors) = {
  if type(authors) != array {
    authors = (authors,)
  }
  align(right)[
    #block(
      width: 40%,
      [
        #align(left)[#quote]
        #line(length: 100%)
        #emph[#authors.join("\n")]
      ]
    )
  ]
}

#epigraph([$E^2 = (m_0c^2)^2 + (p c)^2$], "Albert Einstein")

#epigraph("All human things are subject to decay, and when fate summons, Monarchs must obey", ("Mac Flecknoe", "John Dryden"))
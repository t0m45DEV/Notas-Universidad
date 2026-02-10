#import "../shared/common.typ": *

#let conf(
  titulo: [],
  resumen: [],
  doc,
) = {
  set page(
    paper:"us-letter",
    numbering: "1",
    //columns:2,
  )
  set par(justify: true)
  set text(
    font: "Linux Libertine Display O",
    size: 11pt,
  )

  place(
    top,
    float: true,
    scope: "parent",
    clearance: 2em,
    {
      align(center)[
        #text(weight:"bold", size:20pt)[ #titulo ]
      ]
      par()[
        #text(weight: "bold", size:15pt)[Resumen] \
        #resumen
      ]
    },
  )
  doc
}


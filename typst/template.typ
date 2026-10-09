#let book(
  title: "Libro de Cánticos",
  subtitle: "Volumen",
  author: "Publicaciones Sumedhārāma",
  body
) = {
  // Page setup for A5 book format
  set page(
    paper: "a5",
    margin: (inside: 22mm, outside: 18mm, top: 20mm, bottom: 20mm),
    header: context {
      let page_num = counter(page).get().first()
      if page_num > 1 {
        let headings = query(selector(heading).before(here()))
        if headings.len() > 0 {
          let current_heading = headings.last()
          set text(size: 8pt, fill: rgb("#555555"), font: ("Liberation Sans", "DejaVu Sans", "Arial"))
          grid(
            columns: (1fr, auto),
            if calc.even(page_num) { [ #current_heading.body ] } else { [] },
            if calc.odd(page_num) { [ #current_heading.body ] } else { [] }
          )
          line(length: 100%, stroke: 0.5pt + rgb("#cccccc"))
        }
      }
    },
    footer: context {
      let page_num = counter(page).get().first()
      if page_num > 1 {
        align(center, text(size: 9pt, fill: rgb("#666666"), font: ("Liberation Serif", "DejaVu Serif"))[#page_num])
      }
    }
  )

  // Typography
  set text(
    font: ("Liberation Serif", "DejaVu Serif", "Times New Roman"),
    size: 10pt,
    lang: "es"
  )
  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 0pt
  )

  // Heading styling
  show heading: it => {
    set text(font: ("Liberation Sans", "DejaVu Sans", "Arial"), fill: rgb("#2c3e50"))
    if it.level == 1 {
      pagebreak(weak: true)
      v(2cm)
      align(center)[
        #text(size: 16pt, weight: "bold")[#it.body]
      ]
      v(1.5cm)
    } else if it.level == 2 {
      v(1.2em, weak: true)
      text(size: 12pt, weight: "bold")[#it.body]
      v(0.6em, weak: true)
    } else {
      v(1em, weak: true)
      text(size: 10.5pt, weight: "bold", style: "italic")[#it.body]
      v(0.5em, weak: true)
    }
  }

  body
}

// Helper for bilingual chanting text (Pāli / Spanish)
#let chant(pali, spanish) = {
  block(width: 100%, inset: (bottom: 8pt))[
    #text(style: "italic", fill: rgb("#1a252f"))[#pali] \
    #text(fill: rgb("#333333"))[#spanish]
  ]
}

#let pali(content) = text(style: "italic", fill: rgb("#1a252f"))[#content]
#let translation(content) = text(fill: rgb("#333333"))[#content]

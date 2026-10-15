#let template(
  titulo: "",
  autor: "",
  body
) = {
  // Colores Forest Sangha
  let color-titulo = rgb("#C58E00")
  let color-resaltado = rgb("#AD7121")
  let color-texto = rgb("#5A5D5A")
  let color-fondo-quote = rgb("#EFEFEF")

  set page(
    paper: "a5",
    margin: (x: 25mm, y: 25mm),
    numbering: "1",
    header: context {
      let pg = counter(page).get().first()
      if pg == 1 { return [] } 
      set text(size: 10pt, fill: luma(100), style: "italic")
      block(width: 100%)[
        #set align(left)
        #text(weight: "bold", style: "normal")[#titulo] #h(1fr) #text(style: "normal")[Pág. #pg]
        #v(-0.5em)
        #line(length: 100%, stroke: 0.5pt + luma(4.29%))
      ]
    }
  )

  set text(
    font: "Alegreya Sans",
    size: 11pt,
    fill: color-texto,
    lang: "es"
  )

  set par(justify: true)

  // Estilo de los encabezados
  show heading: it => {
    let size = if it.level == 1 { 22pt } else { 16pt }
    set text(fill: color-titulo, size: size, weight: "bold")
    block(above: 1.5em, below: 1em)[#it]
  }

  // Estilo para citas
  show quote: it => block(
    fill: color-fondo-quote,
    inset: 12pt,
    radius: 5pt,
    width: 100%,
    stroke: (left: 4pt + color-resaltado),
    it
  )

  // PORTADA
  // set page(margin: 0pt, header: none)
  // place(left + horizon, dx: 30mm)[
  //   #text(size: 36pt, weight: "bold", fill: black)[#titulo]
  //   #v(0.5em)
  //   #text(size: 18pt, fill: black, style: "italic")[Documento de Estudio]
  //   #v(1em)
  //   #text(size: 14pt, fill: black)[Por #autor]
  // ]
  // pagebreak()

  // RESTABLECER MÁRGENES Y CONTENIDO
  set page(margin: (x: 25mm, y: 25mm))
  
  body
}

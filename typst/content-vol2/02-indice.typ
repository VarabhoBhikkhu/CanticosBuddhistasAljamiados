// =====================================================================
//  02-indice.typ — Índice y «Lista de Primeras Líneas»
//  Réplica de las páginas 3-7 de main-es-vol2.pdf
//
//  El índice se construye a partir de las marcas que deja el conversor
//  LaTeX → Typst:  #metadata((tipo: "parte"|"cap"|"sub", ...)) <toc>
// =====================================================================

#import "../template-vol2.typ": *

// ---- constantes medidas en el PDF ---------------------------------------
#let W_TOC = 360.7pt // ancho del bloque de texto
#let X_SUB = 15pt // sangría del sub-capítulo
#let X_PARTE = 73.3pt // columna de «Parte N»

// número de página impreso (las páginas 1-9 no se numeran)
#let impreso(pag) = pag - 8

// rótulo de página del índice (línea base 1.3 pt más abajo que el título)
#let num-indice(n) = box(baseline: -1.3pt)[
  #text(font: F-TIT, size: 12.5pt, weight: "bold")[#n]
]

// -------------------------------------------------------------------------
//  Una línea del índice:  [texto] [puntos guía] [número]
// -------------------------------------------------------------------------
#let linea-indice(izq, num, sangria: 0pt) = context {
  let mt = measure(izq)
  let mn = measure(num)
  let disp = W_TOC - sangria - mt.width - mn.width - 6pt
  block(width: 100%, spacing: 0pt)[
    #h(sangria) #izq #box(width: disp)[#repeat[#h(5.7pt).]] #h(6pt) #num
  ]
}

// -------------------------------------------------------------------------
//  Una entrada de capítulo del índice
// -------------------------------------------------------------------------
#let entrada-cap(titulo, num, sub) = {
  let t = text(font: F-PALI, size: 14.9pt)[#titulo]
  if sub == none {
    linea-indice(t, num-indice(num))
  } else {
    block(width: 100%, spacing: 0pt)[
      #text(font: F-PALI, size: 14.9pt)[#titulo]
    ]
    linea-indice(
      text(font: F-PALI, size: 14.9pt)[#sub],
      num-indice(num),
      sangria: X_SUB,
    )
  }
}

// -------------------------------------------------------------------------
//  El índice completo
// -------------------------------------------------------------------------
#context {
  let entradas = query(<toc>)
  let n = entradas.len()
  let i = 0

  // --- cabecera «Índice» --------------------------------------------------
  block(width: 100%, spacing: 0pt)[
    #text(font: F-TIT, size: 25pt, weight: "bold", fill: TINTA)[Índice]
  ]

  while i < n {
    let e = entradas.at(i)
    let tipo = e.value.tipo
    if tipo == "parte" {
      block(width: 100%, spacing: 0pt)[
        #grid(
          columns: (X_PARTE, 1fr, auto),
          column-gutter: 0pt,
          align: (left + bottom, left + bottom, right + bottom),
          text(font: F-TIT, size: 16.9pt, weight: "bold", fill: TINTA)[Parte #e.value.num],
          text(font: F-TIT, size: 16.9pt, weight: "bold", fill: TINTA)[#e.value.titulo],
          text(font: F-TIT, size: 16.9pt, weight: "bold", fill: TINTA)[#impreso(counter(page).at(e.location()).first())],
        )
      ]
      i += 1
    } else if tipo == "cap" {
      let sub = none
      let num = ""
      if i + 1 < n and entradas.at(i + 1).value.tipo == "sub" {
        sub = entradas.at(i + 1)
        let pa = impreso(counter(page).at(e.location()).first())
        let pb = impreso(counter(page).at(sub.location()).first())
        num = str(pa) + " / " + str(pb)
        i += 1
      } else {
        num = str(impreso(counter(page).at(e.location()).first()))
      }
      entrada-cap(e.value.titulo, num, if sub == none { none } else { sub.value.titulo })
      i += 1
    } else {
      i += 1
    }
  }
}

// -------------------------------------------------------------------------
//  «Lista de Primeras Líneas» (empieza en página nueva)
// -------------------------------------------------------------------------
#pagebreak()
#context {
  let lineas = query(<primera-linea>)
  let datos = lineas.map(m => (
    m.value.texto,
    impreso(counter(page).at(m.location()).first()),
  ))
  datos = datos.sorted(key: it => it.first())

  block(width: 100%, spacing: 0pt)[
    #text(font: F-TIT, size: 25pt, weight: "bold", fill: TINTA)[Lista de Primeras Lineas]
  ]
  for d in datos {
    linea-indice(
      text(font: F-PALI, size: 14.9pt)[#d.first()],
      num-indice(d.last()),
    )
  }
}

// =====================================================================
//  template-vol2.typ
//  Réplica de la maquetación de «main-es-vol2.pdf»
//  Libro de Cánticos · Segundo Volumen — Publicaciones Sumedhārāma
//
//  Todas las medidas están tomadas del PDF original (ver helpers/pdf_probe.py)
// =====================================================================

// ---------------------------------------------------------------- paleta
#let GRIS = rgb("#808080") // headrule · instruction · banda lateral
#let TINTA = rgb("#191919") // cabecera · títulos · rótulos
#let NEGRO = rgb("#000000") // cuerpo de texto
#let ORO = rgb("#DEB25D") // "VOLUMEN II" de la portada
#let BLANCO = rgb("#FFFFFF")

// ------------------------------------------------------------ tipografías
#let F-PALI = "Gentium Incantation"
#let F-TIT = "Ubuntu" // Ubuntu-X-Medium.ttf  (familia "Ubuntu", subfamilia "Bold")
#let F-ROT = "Alegreya X Sans SC"
#let F-MARCA = "Carta Magna Line"
#let F-SANS = "Calluna Sans"
#let F-THAI = "Sarabun"
#let F-LAB = "Gentium Book Basic" // etiquetas del glosario (GenBkBasB.ttf)

// --------------------------------------------------------------- página
#let PAG_W = 181mm
#let PAG_H = 250mm
#let MARGEN = (
  top: 20mm, //  56.91 pt
  bottom: 26.86mm, //  76.41 pt
  inside: 20.54mm, //  58.46 pt  (lomo)
  outside: 33.23mm, //  94.54 pt  (borde)
)

// -------------------------------------------------- posiciones medidas
#let X_CAB = 59.0pt // borde izq. de la cabecera
#let W_CAB = 395.6pt // ancho de la cabecera (textwidth + 35 pt)
#let Y_CAB = 7.0pt // offset vertical del encabezado corrido
#let BANDA_Y = 48.8pt
#let BANDA_H = 28pt
#let BANDA_W = 20.6mm // ancho visible de la banda gris exterior
#let X_NUM_R = 469.5pt // borde izq. del número (recto)
#let X_NUM_V = 44.1pt // borde der. del número (verso)
#let Y_NUM = 43.0pt // offset vertical del número
#let INDENT = 22.5pt // \leaderIndent = 1.8em
#let RULE_Y = 76.2pt // filete bajo el título de capítulo
#let X_BLOQUE_R = 59.0pt // borde izq. del bloque de texto (recto)
#let X_BLOQUE_V = 93.9pt // borde izq. del bloque de texto (verso)
#let W_BLOQUE = 360.7pt // ancho del bloque de texto
#let OFF_PARTE = 222.5pt // desplazamiento vertical del título de parte
#let TABCOL = 25pt // 2 \tabcolsep
#let FICHAPAR = 27.3pt // sangría francesa del glosario

// =====================================================================
//  utilidades internas
// =====================================================================

// Último encabezado de nivel `nivel` que empieza en esta página o antes.
#let _ultimo(nivel, pag) = {
  let c = query(heading.where(level: nivel)).filter(
    h => counter(page).at(h.location()).first() <= pag
  )
  if c.len() > 0 { c.last().body } else { [] }
}

// ¿Hay un título de capítulo en esta página?
#let _hay-capitulo(pag) = {
  query(heading.where(level: 2)).any(
    h => counter(page).at(h.location()).first() == pag
  )
}

// =====================================================================
//  fondo de página: banda gris, número, encabezado corrido y filete
// =====================================================================
#let _fondo = context {
  let pag = counter(page).get().first()
  let recto = calc.odd(pag)
  let total = counter(page).final().first()

  // ---- banda gris del margen exterior --------------------------------
  if recto {
    place(dx: 454.6pt, dy: BANDA_Y, rect(width: BANDA_W, height: BANDA_H, fill: GRIS))
  } else {
    place(dx: 0pt, dy: BANDA_Y, rect(width: BANDA_W, height: BANDA_H, fill: GRIS))
  }

  // ---- número de página (blanco, sobre la banda) ----------------------
  if pag >= 10 and pag <= total - 2 {
    let n = pag - 8
    let t = text(font: F-ROT, size: 18.5pt, weight: "bold", fill: BLANCO, tracking: 5pt)[#n]
    if recto {
      place(dx: X_NUM_R, dy: Y_NUM, t)
    } else {
      place(dx: 0pt, dy: Y_NUM, block(width: X_NUM_V, align(right)[#t]))
    }
  }

  // ---- encabezado corrido ---------------------------------------------
  let marcas = query(<marca>).filter(
    m => counter(page).at(m.location()).first() <= pag
  )
  let cap = if marcas.len() > 0 { marcas.last().value.texto } else { "" }
  let partes = query(heading.where(level: 1)).filter(
    h => counter(page).at(h.location()).first() <= pag
  )
  let par = if partes.len() > 0 { lower(partes.last().body) } else { "" }
  let izq = if recto { par } else { lower(cap) }
  let der = if recto { lower(cap) } else { par }
  set text(font: F-ROT, size: 12pt, fill: TINTA)
  place(dx: X_CAB, dy: Y_CAB, izq)
  place(dx: X_CAB, dy: Y_CAB, block(width: W_CAB, align(right)[#der]))
}

// =====================================================================
//  show rules de los encabezados
// =====================================================================
#set heading(numbering: none, outlined: false)

#show heading.where(level: 1): it => block(above: 0pt, below: 0pt)[
  #set text(font: F-TIT, size: 25pt, weight: "bold", fill: TINTA)
  #it.body
]
#show heading.where(level: 2): it => block(above: 0pt, below: 0pt)[
  #set text(font: F-TIT, size: 17pt, weight: "bold", fill: TINTA)
  #it.body
]
#show heading.where(level: 3): it => block(above: 0pt, below: 0pt)[
  #set text(font: F-TIT, size: 13pt, weight: "bold", fill: TINTA)
  #it.body
]
#show heading.where(level: 4): it => block(above: 0pt, below: 0pt)[
  #set text(font: F-TIT, size: 12pt, weight: "bold", fill: TINTA)
  #it.body
]

// =====================================================================
//  bloque del documento
// =====================================================================
#let libro(body) = {
  set page(
    width: PAG_W,
    height: PAG_H,
    margin: MARGEN,
    background: _fondo,
  )
  set text(font: F-PALI, size: 12.5pt, lang: "es", fill: NEGRO)
  set par(justify: false, leading: 21pt, spacing: 5pt, first-line-indent: 0pt)
  body
}

// =====================================================================
//  helpers de contenido
// =====================================================================

// --- cuerpo Pāli (12.5 pt / interlínea 21 pt / párrafo 5 pt) ---------
#let pali(body) = {
  set text(size: 12.5pt)
  set par(leading: 21pt, spacing: 5pt)
  body
}

// --- cuerpo español (12 pt / interlínea 17 pt / párrafo 8 pt) ---------
#let espanol(body) = {
  set text(size: 12pt)
  set par(leading: 17pt, spacing: 8pt)
  body
}

// --- apéndice (11 pt / interlínea 17 pt) ------------------------------
#let apendice(body) = {
  set text(size: 11pt)
  set par(leading: 17pt, spacing: 9pt)
  body
}

// --- título de parte ---------------------------------------------------
#let parte(num, titulo) = {
  page(
    background: {
      place(dx: 444.1pt, dy: 0pt, rect(width: 24.3mm, height: PAG_H, fill: GRIS))
      place(dx: 442.1pt, dy: 51.2pt, rect(width: 82.3pt, height: 27.9pt, fill: BLANCO))
      place(
        dx: 444.1pt,
        dy: 47.0pt,
        text(font: F-ROT, size: 16.9pt, weight: "bold", fill: TINTA)[parte #num],
      )
    },
  )[
    #metadata((tipo: "parte", num: num, titulo: titulo)) <toc>
    #v(OFF_PARTE)
    #block(width: 100%, inset: (right: 15.4pt), align(right)[#heading(level: 1)[#titulo]])
  ]
}

// --- título de capítulo -------------------------------------------------
#let capitulo(titulo) = {
  pagebreak(weak: true)
  heading(level: 2)[
    #titulo
    #metadata((tipo: "marca", texto: titulo)) <marca>
  ]
}

// --- título de sección / subsección -------------------------------------
#let seccion(titulo) = heading(level: 3)[#titulo]
#let subseccion(titulo) = heading(level: 4)[#titulo]

// --- bloque «leader» (sangría 1.8em a ambos lados) ---------------------
#let leader(body) = block(
  width: 100%,
  inset: (left: INDENT, right: INDENT),
  breakable: true,
)[#body]

// --- bloque «paritta» (versos a una columna, sangría 1.8em) ------------
#let paritta(body) = block(
  width: 100%,
  inset: (left: INDENT),
  breakable: true,
)[
  #set par(leading: 21pt, spacing: 7pt)
  #body
]

// --- rótulo centrado [ introducción ] ----------------------------------
#let soloinstr(t) = align(center)[
  #text(font: F-ROT, size: 12.5pt, fill: GRIS)[\[ #lower(t) \]]
]

// --- rótulo en línea [ x ] (alineado a la derecha) ---------------------
#let instr(t) = [#h(1fr) #text(font: F-ROT, size: 12.5pt, fill: GRIS)[\[ #lower(t) \]]]

// --- nota marginal (fuera del bloque de texto) ------------------------
#let sidepar(t) = context {
  let recto = calc.odd(counter(page).get().first())
  let d = if recto { 100% + 12pt } else { -100% - 12pt }
  place(dx: d, dy: -7pt, text(font: F-TIT, size: 10pt, weight: "bold")[#t])
}

// --- cántico de dos columnas (filas de 21 pt) --------------------------
#let solotwochants(..filas) = {
  grid(
    columns: (auto, auto),
    column-gutter: TABCOL,
    row-gutter: 0pt,
    align: left + top,
    ..filas.pos().flatten().map(c => align(left, c)),
  )
}

// --- cántico de dos columnas (filas de 26 pt: arraystretch 1.238) ------
#let twochants(..filas) = {
  grid(
    columns: (auto, auto),
    column-gutter: TABCOL,
    row-gutter: 5pt,
    align: left + top,
    ..filas.pos().flatten().map(c => align(left, c)),
  )
}

// --- cántico de una columna (filas de 21 pt) ---------------------------
#let soloonechants(..filas) = {
  grid(columns: (auto,), row-gutter: 0pt, align: left + top, ..filas.pos().flatten())
}

// --- cántico de una columna (filas de 26 pt) ---------------------------
#let onechants(..filas) = {
  grid(columns: (auto,), row-gutter: 5pt, align: left + top, ..filas.pos().flatten())
}

// --- lista de descripciones (glosario) ---------------------------------
#let descripcion(..entradas) = {
  set par(leading: 17pt, spacing: 9pt, hanging-indent: FICHAPAR)
  for e in entradas.pos() {
    block(width: 100%, inset: (left: FICHAPAR), breakable: true)[
      #text(font: F-LAB, weight: "bold")[#e.at(0)] #e.at(1)
    ]
  }
}

// --- lista con viñetas ---------------------------------------------------
#let lista(..items) = {
  set list(indent: 15pt, body-indent: 8pt, spacing: 4pt)
  for i in items.pos() { list.item(i) }
}

// --- tabla genérica -----------------------------------------------------
#let tabla(..filas) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: 6pt,
    row-gutter: 4pt,
    align: left + top,
    ..filas.flatten(),
  )
}

// --- texto en tailandés --------------------------------------------------
#let thai(t) = text(font: F-THAI)[#t]

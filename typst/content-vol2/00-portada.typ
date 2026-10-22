// =====================================================================
//  00-portada.typ — Contraportada / portada del vol. II
//  Réplica de la página 1 de main-es-vol2.pdf
// =====================================================================

#import "../template-vol2.typ": *

#page(
  margin: 0pt,
  background: image("../../images/vol2-webcover-bg.jpg", width: 100%, height: 100%),
)[
  // ---- «Cánticos» (Carta Magna Line, 79.5 pt) --------------------------
  #place(dx: 0pt, dy: 358pt, block(width: 476.2pt, align(right)[
    #text(font: F-MARCA, size: 79.5pt, fill: rgb("#000000"))[Cánticos]
  ]))

  // ---- VOLUMEN II · DISCURSOS, PARITTAS y CÁNTICOS FUNERARIOS ---------
  #place(dx: 0pt, dy: 476.5pt, block(width: 476.2pt, align(right)[
    #text(font: F-SANS, size: 10.8pt, fill: ORO)[VOLUMEN II]
    #h(1fr)
    #text(font: F-SANS, size: 10.8pt, fill: rgb("#FFFFFF"))[DISCURSOS, PARITTAS y CÁNTICOS FUNERARIOS]
  ]))

  // ---- PĀLI | ESPAÑOL ---------------------------------------------------
  #place(dx: 0pt, dy: 643.8pt, block(width: 476.5pt, align(right)[
    #text(font: F-SANS, size: 10.8pt, fill: rgb("#FFFFFF"))[PĀLI #h(8pt) | #h(8pt) ESPAÑOL]
  ]))
]

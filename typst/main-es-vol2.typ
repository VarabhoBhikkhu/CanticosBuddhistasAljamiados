// =====================================================================
//  main-es-vol2.typ
//  «Libro de Cánticos · Segundo Volumen» — Discursos, Parittas y
//  Cánticos Funerarios (Pāli | Español)
//
//  Réplica en Typst de la maquetación de main-es-vol2.pdf,
//  Publicações Sumedhārāma.
// =====================================================================

#import "template-vol2.typ": *

#show: libro

#set document(
  title: "Libro de Cánticos · Segundo Volumen — Discursos, Parittas y Cánticos Funerarios",
  author: "Publicações Sumedhārāma",
)

// ---------------------------------------------------------------- portada
#include "content-vol2/00-portada.typ"

// ---------------------------------------------------------------- créditos
#include "content-vol2/01-derechos.typ"

// ------------------------------------------- índice y lista de 1as líneas
#pagebreak()
#include "content-vol2/02-indice.typ"

// ---------------------------------------------------- Parte 1 · Discursos
#parte(1, "Los Discursos Cardinales")
#include "content-vol2/suttas.typ"

// ------------------------------------------------------ Parte 2 · Parittas
#parte(2, "Parittas")
#include "content-vol2/parittas.typ"

// ------------------------------------------------- Parte 3 · Cánticos …
#parte(3, [Cánticos Funerarios])
#include "content-vol2/funeral.typ"

// ------------------------------------------------------ Parte 4 · Apéndice
#parte(4, [Apéndice])

// ... apéndice: pronunciación del pāli
#set text(size: 11pt)
#set par(leading: 17pt, spacing: 9pt, justify: false)
#capitulo[Pronunciación en Pāli]
#include "content-vol2/pronuncia.typ"

// ... apéndice: etiqueta monástica
#include "content-vol2/05-etiqueta.typ"

// ... apéndice: glosario
#capitulo[Glosario de términos en Pāli]
#include "content-vol2/glossary.typ"

// ... apéndice: cuidado con los libros de Dhamma
#include "content-vol2/03-cuidados.typ"

// ... apéndice: derechos y restricciones de la licencia
#include "content-vol2/04-licencia.typ"

// ============================================================
//  Libro de Cánticos — Vol. I (Pāli | Español)
//  Plantilla Typst que replica la maqueta del PDF
//  Compilar con: typst compile libro-canticos.typ
// ============================================================

// ---------- Metadatos ----------
#set document(
  title: "Libro de Cánticos – Volumen I",
  author: "Publicações Sumedhārāma",
)

// ---------- Tipografías (las del original) ----------
#let f-texto = ("Gentium Plus", "Gentium Incantation", "Gentium Book Plus")
#let f-sans = ("Alegreya Sans", "Ubuntu")
#let color-acento = rgb("#7a3b12")

// ---------- Página ----------
#set page(
  width: 148mm, height: 210mm,      // A5
  margin: (inside: 18mm, outside: 14mm, top: 20mm, bottom: 18mm),
)
#set text(font: f-texto, size: 10.5pt, lang: "es")
#set par(justify: false, leading: 0.6em, spacing: 0.8em)

// ---------- Encabezados ----------
// Nivel 1 = "Parte N" ; Nivel 2 = cada cántico / reflexión
#set heading(numbering: (..n) => if n.pos().len() == 1 { [Parte #n.pos().first()] })

#show heading.where(level: 1): it => {
  v(1fr) 
  align(center)[
    #text(font: f-sans, size: 14pt, fill: color-acento, tracking: 2pt, upper(
      if it.numbering != none { numbering(it.numbering, ..counter(heading).at(it.location())) }
    ))
    #v(0.6em)
    #text(font: f-sans, size: 28pt, weight: "bold")[#it.body]
  ]
  v(1fr)
}

#show heading.where(level: 2): it => {
  v(0.4em)
  block(sticky: true, below: 0.9em)[
    #text(font: f-sans, size: 15pt, weight: "bold", fill: color-acento)[#it.body]
    #v(-0.3em)
    #line(length: 100%, stroke: 0.5pt + color-acento)
  ]
}

// ---------- Cabecera / pie con título de sección ----------
#let seccion-actual() = context {
  let pg = here().page()
  let previos = query(heading.where(level: 1).before(here()))
  if previos.len() == 0 { return [] }
  let h = previos.last()
  let n = counter(heading).at(h.location()).first()
  [#h.body]
}
#let cantico-actual() = context {
  let previos = query(heading.where(level: 2).before(here()))
  if previos.len() == 0 { return [] }
  [#previos.last().body]
}

#set page(
  header: context {
    let pg = counter(page).get().first()
    // No cabecera en páginas de portada de parte
    let en-parte = query(heading.where(level: 1)).any(h => h.location().page() == here().page())
    if en-parte { return }
    set text(font: f-sans, size: 8.5pt, fill: luma(90), style: "italic")
    if calc.even(here().page()) {
      [#pg #h(1fr) #lower(seccion-actual())]
    } else {
      [#cantico-actual() #h(1fr) #pg]
    }
    v(-0.4em)
    line(length: 100%, stroke: 0.3pt + luma(160))
  },
)

// ============================================================
//  Funciones auxiliares para el contenido
// ============================================================

// Un verso: texto en Pāli y debajo la traducción
#let pl(pali, es) = block(breakable: false, below: 0.85em)[
  #text(weight: "regular", size: 16.5pt)[#pali] \
  #text(font: "Arabico Personal Use",style: "italic", fill: luma(50), size: 15pt)[#es]
]

// Solo Pāli (p. ej. vespertinos, donde pali y español están en páginas enfrentadas)
#let p(txt) = block(below: 0.35em)[#txt]
// Solo traducción
#let es(txt) = block(below: 0.35em)[#text(style: "italic", fill: luma(50))[#txt]]

// Indicaciones
#let rev = align(right)[#text(size: 9pt, fill: luma(90))[\[ reverencia \]]]
#let lider(txt) = text(fill: luma(90))[\[#txt\]]
#let nota(txt) = block(above: 0.8em, below: 0.8em)[
  #text(size: 9pt, style: "italic", fill: luma(90))[\[ #txt \]]
]
#let tres(txt) = nota(txt)

// Lista numerada de preceptos (Pāli + traducción)
#let precepto(n, pali, traduccion) = grid(
  columns: (1.6em, 1fr), column-gutter: 0.2em,
  [#n.], [#pali \ #text(style: "italic", fill: luma(50))[#traduccion]],
)
#v(0pt)

// Entrada de glosario
#let gl(term, def) = block(below: 0.55em)[
  #text(weight: "bold")[#term] #def
]

// ============================================================
//  PORTADA Y PÁGINAS PRELIMINARES
// ============================================================
#set page(header: none, numbering: none)

#align(center + horizon)[
  #text(font: f-sans, size: 34pt, weight: "bold", fill: color-acento)[Cánticos]
  #v(0.6em)
  #text(font: f-sans, size: 12pt, tracking: 1.5pt)[VOLUMEN I]
  #v(0.4em)
  #text(font: f-sans, size: 14pt, weight: "medium")[
    CÁNTICOS MATINALES Y VESPERTINOS (PŪJĀ) Y REFLEXIONES
  ]
  #v(1em)
  #text(font: f-sans, size: 12pt)[PĀLI #h(0.6em) | #h(0.6em) ESPAÑOL ANDALUSI]
]
#pagebreak()

// Anteportada
#align(center + horizon)[
  #text(font: f-sans, size: 26pt, weight: "bold")[Libro de Cánticos]
  #v(0.8em)
  #text(size: 14pt)[Cánticos Matinales y Vespertinos (Pūjā) y Reflexiones]
  #v(0.4em)
  #text(size: 13pt, style: "italic")[Pāli y Español Aljamiado]
  #v(2.5em)
  #text(font: f-sans, size: 12pt)[Publicaciones Sumedhārāma]
  #linebreak()
  #text(font: f-sans, size: 10pt)[www.sumedharama.pt]
]
#pagebreak()

// Créditos
#set text(size: 9.5pt)
#align(center)[
  *Para distribución gratuita* \
  #text(style: "italic")[सब्बदानं धम्मदानं जिनाति] \
  ‘La ofrenda de Dhamma es superior a cualquier otra ofrenda.’
]
#v(1em)
Este libro se encuentra disponible para distribución gratuita en
www.sumedharama.pt

Copyright © Publicações Sumedhārāma 2026

#v(0.4em)
Editores: Ajahn Amaro, Ajahn Gavesako \
Traductor:  Tahn Varabho\
Formato: Ajahn Gambhīro \


#v(0.4em)
Este trabajo se encuentra bajo licencia Creative Commons
Atribución-NoComercial-SinDerivadas 4.0 Internacional.
Véase página 142 para más detalles sobre derechos y restricciones de esta licencia.

#v(0.4em)
Fuentes utilizadas: Gentium Incantation, Alegreya Sans y Ubuntu. \
Segunda edición, 2025
#set text(size: 10.5pt)
#pagebreak()

// ============================================================
//  ÍNDICE AUTOGENERADO
// ============================================================
#show outline.entry.where(level: 1): it => {
  v(0.9em, weak: true)
  set text(font: f-sans, weight: "bold", size: 11pt)
  it
}
#show outline.entry.where(level: 2): it => {
  set text(size: 10pt)
  it
}

#block[
  #text(font: f-sans, size: 22pt, weight: "bold", fill: color-acento)[Índice]
  #v(0.6em)
]
#outline(title: none, depth: 2, indent: 1.2em)

#pagebreak()

// ---------- Numeración arábiga de aquí en adelante ----------
#set page(numbering: "1")
#counter(page).update(1)

// ============================================================
//  PARTE 1 — CÁNTICOS MATINALES
// ============================================================
#pagebreak(to: "odd")
= Cánticos Matinales

== Dedicación de Ofrendas
// #pl("Pāli…", "Traducción…")   ← pegar aquí los versos de las pp. 2–3
#pl("[यो सो] भगवा अरहं सम्मासम्बुद्धो", "Al Buddha, Az-Zāhid, que totalmente alcanzó la iluminación perfecta,
اَلَاکْشْسَالْشُ، ءَالْمَاَاشْتْرُ، کَاتُتَلْمَانْتَا اَلْکَنْسُ لَاِلُمِنَسِيُنْ بَّارْفَاکْتَ،")

#pl("स्वाक्खातो येन भगवता धम्मो", "A las enseñanzas, tan bien explicadas por Él,
اَلَشَانْشَانَّنْسَشْ، تَنْ بِيَانْ ءَاکْشْبّْلِکَذَشْ بُّرَالْ،")

== Homenaje Preliminar

== Homenaje al Buddha

== Homenaje al Dhamma

== Homenaje a la Saṅgha

== Saludo a la Joya Triple

== Homenaje de Cierre

// ============================================================
//  PARTE 2 — CÁNTICOS VESPERTINOS
//  (en el original: Pāli en página par, traducción en la impar)
// ============================================================
#pagebreak(to: "odd")
= Cánticos Vespertinos



== Dedicación de Ofrendas

== Homenaje Preliminar

== Remembranza del Buddha

== Elogio Supremo al Buddha

== Remembranza del Dhamma

== Elogio Supremo al Dhamma

== Remembranza de la Saṅgha

== Elogio Supremo a la Saṅgha

== Homenaje de Cierre

// ============================================================
//  PARTE 3 — REFLEXIONES Y REMEMBRANZAS
// ============================================================
#pagebreak(to: "odd")
= Reflexiones y Remembranzas

== Versos de Dedicación de Mérito
== Versos sobre el Beneficio de la Dádiva
== Mettā Sutta
== Once Beneficios de la Práctica de Mettā
== Irradiando los Estados Divinos
== Las Supremas Bendiciones
== Así como Ríos
== Reflexión sobre el Bienestar Universal
== Reflexión sobre los Cuatro Requisitos
== Reflexión sobre las Treinta y dos Partes
== Reflexión sobre las Cualidades Repugnantes de nuestros Requisitos
== Cinco Temas para Recordar Frecuentemente
== Diez temas para Recordar Frecuentemente
== Verdaderos y Falsos Refugios
== Versos sobre la Riqueza de Uno que es Noble
== Versos sobre las Tres Características
== Versos sobre la Carga
== Versos sobre una Auspiciosa Noche
== Versos de Respeto por el Dhamma
== Ovāda-Pāṭimokkha
== Versos sobre la Primera Exclamación de Buddha
== Versos sobre las Últimas Instrucciones
== Surgen a Partir de una Causa
== Reflexión sobre lo Incondicionado
== Breve Consejo a Gotamī
== La Raíz de Todas las Cosas
== Ānāpānassati-sutta
== La Enseñanza sobre el Óctuple Noble Sendero
== La Enseñanza sobre el Esfuerzo acorde con el Dhamma
== Los Versos de Tāyana
== Bhikkhu-aparihāniya-dhamma-sutta

// ============================================================
//  PARTE 4 — SOLICITUDES FORMALES
// ============================================================
= Solicitudes Formales

== Añjali
== Solicitando una Enseñanza de Dhamma
== Reconocimiento de una Enseñanza
== Petición de Cántico de Parittas
== Solicitud de los Tres Refugios y Cinco Preceptos
== Los Tres Refugios
== Los Cinco Preceptos
== Petición de los Tres Refugios y Ocho Preceptos
== Los Tres Refugios
== Los Ocho Preceptos

// ============================================================
//  PARTE 5 — APÉNDICE
// ============================================================
= Apéndice

== Pronunciación en Pāli
== Etiqueta monástica
== Glosario de términos en Pāli
// #gl("Anatta", "Literalmente, ‘no-yo’, …")

// ============================================================
//  LISTA DE PRIMERAS LÍNEAS (autogenerada con #make-index)
//  Marcar cada primera línea con #pri[texto] dentro del contenido
//  y descomentar el bloque siguiente para generarla.
// ============================================================
// #import "@preview/in-dexes:0.7.0": *
// #make-index(title: "Lista de Primeras Líneas")

// ---------- Cuidado de los libros de Dhamma + licencia ----------
#pagebreak(to: "odd")
#align(center + horizon)[
  #block(width: 85%)[
    #set text(size: 9.5pt)
    *Cuidado de los libros de Dhamma* \
    Los libros de Dhamma contienen las enseñanzas de Buddha y señalan el camino
    hacia la liberación de saṁsara. Por lo tanto, deben tratarse con respeto.
  ]
]

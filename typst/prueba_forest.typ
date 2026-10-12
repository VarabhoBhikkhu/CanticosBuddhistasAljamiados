#set page(
  paper: "a5",
  margin: (x: 25mm, y: 25mm),
)

// Colores Forest Sangha
#let color-titulo = rgb("#C58E00")
#let color-resaltado = rgb("#AD7121")
#let color-texto = rgb("#5A5D5A")
#let color-fondo-quote = rgb("#EFEFEF")
#let color-biblio = rgb("#239dad")

#set text(
  font: "Alegreya Sans",
  size: 11pt,
  fill: color-texto,
  lang: "es"
)

#set par(justify: true)

// Estilo de los encabezados
#show heading: it => {
  let size = if it.level == 1 { 20pt } else { 16pt }
  set text(fill: color-titulo, size: size, weight: "bold")
  block(above: 1.5em, below: 1em)[#it]
}

// Estilo para citas o bloques destacados
#show quote: it => block(
  fill: color-fondo-quote,
  inset: 10pt,
  radius: 5pt,
  width: 100%,
  stroke: (left: 4pt + color-resaltado),
  it
)

// PORTADA
#set page(margin: 0pt)
#place(center + horizon)[
  #image("../images/BuddhaFondo.jpg", width: 100%, height: 100%, fit: "cover")
]
#place(left + horizon, dx: 30mm)[
  #text(size: 32pt, weight: "bold", fill: white)[Prueba Forest Sangha]
]
#pagebreak()

// RESTABLECER MÁRGENES PARA EL RESTO DEL DOCUMENTO
#set page(margin: (x: 25mm, y: 25mm))

// ÍNDICE
#outline(indent: 2em)
#pagebreak()

= Capítulo 1: Los Senderos del Bosque

El camino hacia la serenidad comienza con un solo paso consciente. En la espesura del bosque, el silencio no es la ausencia de sonido, sino la presencia de la paz interior. 

#lorem(60)

#quote[
  "La verdadera riqueza no reside en lo que poseemos, sino en lo que somos capaces de soltar."
]

== Reflexiones sobre la Calma
#lorem(40)

= Capítulo 2: El Despertar de la Mente

Cuando la mente se aquieta, la realidad emerge con una claridad cristalina. La práctica constante de la atención plena nos permite observar el flujo de los pensamientos sin identificarnos con ellos.

#lorem(60)

#text(fill: color-resaltado, weight: "bold")[Importante:] La disciplina no es una restricción, sino la llave que abre la puerta a la verdadera libertad.

== La Danza de la Impermanencia
#lorem(40)

= Capítulo 3: La Luz de la Sabiduría

La sabiduría no se encuentra en los libros, sino en la experiencia directa de la verdad. Al observar el surgimiento y el cese de todas las cosas, el corazón se libera del apego.

#lorem(60)

#quote[
  "Como la gota de rocío que desaparece al salir el sol, así es la naturaleza de nuestra existencia."
]

== El Retorno al Centro
#lorem(40)

#pagebreak()

= Glosario de Términos

#grid(
  columns: (1fr, 2fr),
  gutter: 1em,
  text(weight: "bold")[Término], text(weight: "bold")[Definición],
  [Dhamma], [La ley universal, las enseñanzas del Buddha.],
  [Sati], [Atención plena o conciencia del momento presente.],
  [Nibbāna], [El estado de liberación total del sufrimiento.],
  [Saṅgha], [La comunidad de practicantes y monjes.]
)

#v(2em)

= Bibliografía

#set text(fill: color-biblio)
- *Tahn Varabho*. "Estudios sobre el Cántico Monástico". Ediciones Forest Sangha, 2026.
- *Ajahn Amaro*. "La Práctica del Bosque en la Actualidad". Monasterio Sumedhārāma, 2025.
- *Canón Pali*. Sutta Pitaka, Majjhima Nikaya.

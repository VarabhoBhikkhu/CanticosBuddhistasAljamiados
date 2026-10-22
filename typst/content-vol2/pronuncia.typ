// =====================================================================
//  pronunciacion.typ — «Pronunciación en Pāli» (capítulo apendicial)
//  Réplica de las páginas 88-90 de main-es-vol2.pdf
// =====================================================================

#import "../template-vol2.typ": *

// --- sílila subrayada (\prul) ---------------------------------------------
#let prul(x) = text(style: "italic")[#underline(x, offset: -1.8pt, stroke: 0.5pt)]

// --- tabla de dos columnas (letra + descripción) -------------------------
#let tabla-vocales(..filas) = grid(
  columns: (5mm, 1fr),
  column-gutter: 25pt, // 2 \tabcolsep
  row-gutter: 4pt,
  align: left + top,
  ..filas.pos().flatten(),
)

// --- tabla de tres columnas (letra + letra + ejemplo) -------------------
#let tabla-tres(..filas) = grid(
  columns: (5mm, 5mm, 1fr),
  column-gutter: 25pt,
  row-gutter: 4pt,
  align: left + top,
  ..filas.pos().flatten(),
)

#seccion[Las Vocales]

#tabla-vocales(
  [#emph[a]], [Como la ‘a’ en la palabra #emph[un#prul[a]].],
  [#emph[ā]], [Larga, como en #emph[#prul[á]gua].],
  [#emph[e]], [Como en #emph[p#prul[e]ra, m#prul[e]sa, m#prul[e]s].],
  [#emph[i]], [Corta, como en #emph[v#prul[i]da, l#prul[i]bro, h#prul[i]jo].],
  [#emph[ī]], [Larga, como en #emph[Mar#prul[í]a, polic#prul[í]a].],
  [#emph[o]], [Como en #emph[b#prul[o]la, fl#prul[o]r].],
  [#emph[u]], [Corta, como en #emph[p#prul[u]reza, m#prul[u]ndo].],
  [#emph[ū]], [Larga, como en #emph[m#prul[ú]sica, d#prul[u]da].],
)

#seccion[Las Consonantes]

#tabla-vocales(
  [#emph[c]], [Es pronunciada como #emph[tch] en #emph[hecho] o #emph[chantaje], nunca como #emph[c] en #emph[caballo] o #emph[cuando].],
  [#emph[g]], [Como en #emph[gusano] o #emph[gato].],
  [#emph[h]], [Ya sea colocada inmediatamente después de consonantes o después de consonantes dobles, la #emph[h] es siempre aspirada como un soplo en suspiro gutural, típico de la lengua inglesa; como en el inglés:],
)

#tabla-tres(
  [], [#emph[bh]], [#emph[ca#prul[bh]orse]],
  [], [#emph[ch]], [#emph[ran#prul[ch-h]ouse]],
  [], [#emph[dh]], [#emph[han#prul[dh]old]],
  [], [#emph[gh]], [#emph[ba#prul[g-h]andle]],
  [], [#emph[jh]], [#emph[sle#prul[dgeh]ammer]],
)

#tabla-vocales(
  [#emph[j]], [No como en #emph[jarra], sino como en la palabra inglesa #emph[#prul[j]oy].],
  [#emph[ṁ]], [El denominado ‘nasal’ es como #emph[e#prul[ng]añar], o como en la palabra inglesa #emph[so#prul[ng]].],
  [#emph[s]], [Siempre como en #emph[#prul[s]ublimar] o en #emph[ca#prul[s]a].],
  [#emph[ñ]], [Como la #emph[ñ] normal en la lengua española; ex: #emph[Espa#prul[ñ]a].],
  [#emph[ph]], [Como la #emph[p] seguida de suspiro gutural en la palabra inglesa #emph[a#prul[pp]ear].],
  [#emph[th]], [Como la #emph[t] seguida de suspiro gutural en las palabras #emph[#prul[th]at, #prul[th]ese].],
  [#emph[y]], [Como la #emph[y] en #emph[ma#prul[y]o] o en #emph[pla#prul[y]a].],
)

#v(10pt)

#emph[ṭ, ṭh, ḍ, ḍh:] Sonidos producidos con la lengua, denominados cerebrales; al pronunciarlos se debe presionar la lengua contra la parte anterior del paladar.

#emph[Consonantes dobles:] Cada una debe ser pronunciada, como #emph[bb] en el término inglés #emph[subbase].

#seccion[Técnica de Cánticos]

Una vez que haya usted comprendido el sistema de pronunciación pāli y la siguiente técnica de canto, podrá cantar cualquier texto en pāli con el ritmo correcto.

#strong[Sílabas cortas] terminan en #strong[a], en #strong[i] corta o en #strong[u] corta. Todas las demás sílabas son largas. Sílabas largas toman el doble de tiempo que las sílabas cortas --- como dos tiempos dentro de un compás (una blanca) en vez de uno (una negra). Esto es lo que da al cántico su ritmo particular.

#align(center)[
  #grid(
    columns: (auto,) * 21,
    column-gutter: 1.8pt,
    align: center + bottom,
    [BUD], [·], [DHO], [#h(0.5em)], [SU], [·], [SUD], [·], [DHO], [#h(0.5em)],
    [KA], [·], [RU], [·], [ṆĀ], [#h(0.5em)], [MA], [·], [HAṆ], [·], [ṆA], [·], [VO],
    [1], [], [1], [], [½], [], [1], [], [1], [], [½], [], [½], [], [1], [], [½], [], [1], [], [½], [], [1],
  )
]

Dos detalles importantes a tener en cuenta cuendo se separan las sílabas:

#strong[1.] Sílabas con dobles consonantes quedan divididas de esta manera:

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 12pt,
    align: center + bottom,
    grid(
      columns: (auto, auto, auto, auto, auto),
      column-gutter: 4pt,
      align: center + bottom,
      [], [A], [·], [NIC], [·], [CA],
      [], [½], [], [1], [], [½],
      [(no], [A], [·], [NI], [·], [CCA)],
      [], [½], [], [½], [], [½],
    ),
    grid(
      columns: (auto, auto, auto, auto, auto),
      column-gutter: 4pt,
      align: center + bottom,
      [], [PUG], [·], [GA], [·], [LĀ],
      [], [1], [], [½], [], [1],
      [(no], [PU], [·], [GGA], [·], [LĀ)],
      [], [½], [], [½], [], [1],
    ),
  )
]

Siempre se pronuncian por separado, e.g. #strong[dd] en ‘uddeso’ como en ‘sed-de’, u otros ejemplos: ‘pan-negro’, ‘sal-limpio’, ‘hay-yerba’, ‘dad-dátiles, ‘más-sabor’.

#strong[2.] #strong[Consonantes aspiradas] como #strong[bh, dh] etc. cuentan como una sola consonante y no son divididas (Así #strong[am·hā·kaṁ], pero #strong[sa·dham·maṁ], no #strong[sad·ham·maṁ] u otro ejemplo: #strong[Bud·dho] y no #strong[Bu·ddho]).

La pronunciación precisa y la correcta separación de las sílabas son especialmente importantes cuando alguien está interesado en aprender pāli y comprender/memorizar el significado de los suttas y otros cánticos; de lo contrario, su significado se distorsionará.

#strong[Un ejemplo para ilustrar esto:]

La palabra Pāli ‘#strong[sukka]’ significa ‘brillante’; ‘#strong[sukkha]’ significa ‘seco’; ‘#strong[sukha]’ --- ‘felicidad’; ‘#strong[suka]’ --- ‘loro’ and ‘#strong[sūka]’ --- ‘una espiga de cebada’. Así, si se canta ‘#strong[sukha]’ con ‘#strong[k]’ en lugar de ‘#strong[kh]’, cantaría usted ‘loro’ en lugar de ‘felicidad’.

Una regla general para comprender la práctica del canto es escuchar atentamente lo que canta el líder y seguirlo, manteniendo el mismo tono, tempo y velocidad. Todas las voces deben integrarse en una sola.

#seccion[Puntuación, marcas tonales y pausas en esta edición]

[Los corchetes] indican partes que suelen ser cantadas solo por el líder, pero las costumbres de canto difieren entre los monasterios.

La barra / indica variaciones de las formas masculinas o femeninas según quien las cante, o formas singulares y plurales al cantar solo o en grupo.

Las marcas tonales indican cambios de tono, generalmente un tono completo hacia arriba o hacia abajo.

#grid(
  columns: (auto, 1fr),
  column-gutter: 25pt,
  row-gutter: 4pt,
  align: left + top,
  [Tono alto:], [no꜓ble],
  [Tono bajo:], [excel꜕so],
)

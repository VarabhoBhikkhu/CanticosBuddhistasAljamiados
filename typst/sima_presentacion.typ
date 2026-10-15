#set page(
  paper: "a5",
  margin: (x: 11mm, y: 11mm),
  numbering: "1",
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
  lang: "en"
)

#set par(justify: true)

// Cabecera del documento
#set page(
  header: context {
    let pg = counter(page).get().first()
    if pg == 1 { return [] } // No cabecera en la portada
    set text(size: 10pt, fill: luma(100), style: "italic")
    block(width: 100%)[
      #set align(left)
      #text(weight: "bold", style: "upright")[The Sīmā Boundary - Presentation by Ajahn Gavesako] #h(1fr) #text(style: "upright")[Pág. #pg]
      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt + luma(4.29%))
    ]
  }
)

// Estilo de los encabezados
#show heading: it => {
  let size = if it.level == 1 { 22pt } else { 16pt }
  set text(fill: color-titulo, size: size, weight: "bold")
  block(above: 1.5em, below: 1em)[#it]
}

// Estilo para citas y bloques de texto original
#show quote: it => block(
  fill: color-fondo-quote,
  inset: 12pt,
  radius: 5pt,
  width: 100%,
  stroke: (left: 4pt + color-resaltado),
  it
)

// PORTADA
#set page(margin: 0pt, header: none)
#place(left + horizon, dx: 30mm)[
  #text(size: 36pt, weight: "bold", fill: black)[The Sīmā Boundary]
  #v(0.5em)
  #text(size: 18pt, fill: black, style: "italic")[A Study on Monastic Territories and Rituals]
  #v(1em)
  #text(size: 14pt, fill: black)[By Ajahn Gavesako]
]
#pagebreak()

// RESTABLECER MÁRGENES
#set page(margin: (x: 25mm, y: 25mm))

// ÍNDICE
#outline(indent: 2em)
#pagebreak()

= Pointing out and binding

Pointing out and binding
The earliest Vinaya procedure for establishing a sīmā was conceptually simple: monks authorized
or agreed upon (sammannati) certain natural landmarks – a rock, a tree, a road – as the limits of
their communal territory. The act was essentially one of collective recognition and consent, pointing
out (kitteti) features that already existed in the landscape. Linear features such as rivers and roads
were particularly useful in this early method precisely because they were unambiguous and easily
recognizable: a river is a boundary in an intuitive, practical sense, and everyone could see it. The
area of the early sīmās was typically very large, several kilometres across, and monks living there
would regularly come together for the uposatha ceremony. They did not have access to a geographic
map of the area on which ideal straight lines can be drawn. Instead, they would recognize the
important landmarks of the area they lived in. For example, they could define their area by pointing
out “from that hill over there, along the stream until it meets the road, then along the road until it
reaches the pond, then up to a big rock on the edge of the forest, and along the forest back to the
hill.”

#image("/images/sima_p1_i5.jpeg")

What the commentarial tradition did, particularly from the Samantapāsādikā onward, was to
reframe this act through the metaphor of binding (bandhati). Rather than monks simply agreeing
that certain landmarks are the boundary, they now conceptually connect those markers to one
another, as if drawing a line or pulling a rope from point to point in a clockwise circuit until the
loop closes back on itself. This newer term emphasizes the ritual method of connecting boundary
markers (nimitta) to delineate the territory. In the early Vinaya, a formally established territory is
called samāna-saṃvāsa sīmā (territory of shared communion). Following the introduction of the
root bandh in the commentaries, the term baddha sīmā (tied-off territory) became the standard
designation

#align(center)[#image("/images/sima_p1_i12.jpeg")]

The territory is now defined by the directional act of tying marker to marker. And this geometric
logic imposed a new demand on linear features: a winding river or road as a whole could no longer
serve as a marker, since a rope cannot be easily tied to it. A specific, singular point on that road or
riverbank now had to be pinpointed, through which the imaginary connecting line would pass. The
result of this process is a closed geometric figure with legal existence, the baddha sīmā, rather than
a loose collection of agreed-upon landmarks. It has to follow the rules of valid polygon
construction: each marker must be a genuinely distinct point on the perimeter, and the perimeter
must fully enclose the territory without self-intersection.

== The Eight Directions
In the Vinaya Piṭaka, the eight cardinal and inter-cardinal directions are not mentioned as a requirement for establishing a sīmā boundary. Instead, the original canonical rules regarding boundary markers (*nimitta*) are far simpler, with the specific directional layout being a later commentarial development. The Mahāvagga simply states that these markers must be announced or pointed out (*kitteti*), but it does not describe the method for doing so, nor does it specify their number or placement:

#quote[
  Yāvatā samantā nimittā kittitā yadi saṅghassa pattakallaṁ saṅgho etehi nimittehi sīmaṃ sammanneyya samānasaṁvāsaṃ ekuposathaṃ. \
  _If the Saṅgha is ready, then – as far as those markers that have been pointed out all around – it should authorize by those markers a territory of shared communion, of a single uposatha._
]

The practice of using eight markers specifically aligned with the eight cardinal and inter-cardinal directions originates in the later commentaries. The *Samantapāsādikā* (by Buddhaghosa, 5th century Sri Lanka) introduced the detailed ritual for “tying off” (*bandhati*) a territory. It describes a process where monks proceed clockwise from one marker to the next, eventually returning to the first marker to close the loop. It mentions the specific questions used to announce the eight directions (e.g., Puratthimāya disāya kiṃ nimittaṃ – “What is the marker in the eastern direction?”). Although it technically allows a sīmā to have anywhere from 3 to 100 markers, the rectangular shape became the standard.

== The Vimativinodanī-ṭīkā
The Vimativinodanī-ṭīkā originated in South India and was composed at the end of the 12th century. It was written by Coḷiya Kassapa, a South Indian monk. The subcommentary was written from the perspective of the South Indian (Coḷiya) monks during a period of significant interaction between South Indian and Sri Lankan monastic orders. The proximity allowed monks to observe deviating practices and differences in their Vinaya interpretation, which formed the basis for later legal disputes. As the third subcommentary on the Vinaya, it is noted for being highly innovative and more detailed than earlier works. It is the first Pāli text to describe certain new ritual techniques, such as the method for cancelling unknown sīmā territories. Another innovation which it introduced was the replacement of the real name of upasampadā candidates with “Nāga” and that of the preceptor with “Tissa”. Despite the dispute with the Sri Lankan tradition, the Vimativinodanī became highly influential across the Theravāda world and its new ritual forms are widely accepted as the standard until today.

#image("/images/sima_p1_i17.jpeg")

= Boundary Markers (Nimitta)

== What is a marker
The Vinayamukha composed by Vajirañāṇavarorasa has the following description:

#quote[
  The marking of the sīmā with nimitta could be such as: in the east it extends from such-and-such a river to such-and-such a lagoon; in the south, from such-and-such a hill to such-and-such a range of rocks; in the west, to such-and-such a path; in the north, to the edge of such-and-such a grove.
]

The use of these six kinds of nimitta suggests that in those days the areas of sīmā were large. Sīmā can be marked with these six objects as nimitta. Rocks, trees, ant-hills, ponds or wells, are also permanent things, but they are smaller than the six mentioned above. I understand that they are used as nimitta of sīmā located on mountains or in jungles which cannot be marked by groves or hills. Moreover, they are used in areas where larger objects are not available.

=== Paths
A footpath or a cart-track still in use can be used as a nimitta. A path of the length of two or three villages can be used. Paths which split from the main path and which join up again a short distance later and disused paths are prohibited from use.

=== Water
#align(center)[#image("../images/sima_p1_i1.jpeg", width: 80%)]

Water means the still water in lagoons, marshes, ponds or wells. In the old commentary called the Andhaka-atthakathā it is prohibited to take the water in a deep well in which a pulley or something similar is used to draw out water as a nimitta. It is explained that that in such wells the amount of water is very little and they can go dry. The ācariya who composed the Commentary on the Mahāvagga opposes that explanation as unsuitable, calling it only the author's own opinion. He himself explained still water as even that in a wallow dug by pigs in a children's playground, or even water which is brought by pot and poured into a pit which was dug that moment. If that water can remain until the end of the chanting of the kammavācā, however small an amount remains, this can be used. But in that place, he added, it is proper to construct a pile of rocks or a sand-hill or an earthen-hill, or a fixed rock, or a wooden pole as a marker. I am amazed that the ācariya who composed the Mahāvagga commentary dared to contradict a reasonable view so strongly and shamelessly, while (himself) comparing vinaya-kamma with playthings. He completely misunderstands the flavour (of the passage); it is quite disturbing.

These objects are limited to being nimitta on one side only, and are prohibited from being used on another side. For example, the same path or the same river encircling the sīmā on many sides, if determined as nimitta on one side, is prohibited from being determined again on another side. However, they are used in marking a country's borders: after consideration, I can see no objection – these objects may be used either similarly or differently from the rest.

== The Critical Approach of Prince Vajirañāṇavarorasa
Prince Vajirañāṇavarorasa was exposed to English education and scientific approach as he was growing up in the palace of King Chulalongkorn (in the years 1872–1876). In his interpretations he often disagrees openly not only with the commentaries, but also with the Vibhaṅga itself, treating the base rules, the Vibhaṅga’s case-law elaboration, and the later commentaries as separable layers to evaluate and sometimes reject individually. He displays independent analytical rationalism, having been trained in law and administration, and applying his own critical judgment to reconcile or question the inherited tradition. 

King Chulalongkorn was an early patron and supporter of the Pali Text Society in England because he valued their work and general approach to publishing Pali texts. Chulalongkorn’s circle of literate monks and princes was actively exchanging texts and manuscripts with Rhys Davids from the mid-1890s onward. During those years Vajirañāṇavarorasa was patriarch of the Dhammayuttika order, abbot of Wat Boworniwet, and was beginning the intellectual work that would become the Vinayamukha (written from 1913). It is very likely that he was influenced by the European historical-critical project of dating and stratifying the Pali texts according to their authenticity. Rhys Davids, as the secretary of the Royal Asiatic Society, wrote to Vajirañāṇavarorasa in 1898 to inform him that he has been “elected an Honorary Member of the Society in consideration of the distinguished services you have rendered to the attainment of the objects of the Society … and the distinguished merits of your Highness’s work as a scholar and an editor of those ancient Pali texts, so important from the point of view of the Society.”

Here we can see that he questions the commentarial prohibition of using certain continuous landmarks like roads or rivers to mark the edge of the sīmā. There is no such stipulation in the original rule formulation in the Mahāvagga. Giving more weight to the older canonical text, he follows common sense and suggests that such continuous markers can be used differently from the more typical stone nimitta. This would of course challenge the standard shape of a perfect rectangle that has become the norm for sīmā since the time of the commentaries. In the early days the monks were more concerned with practical and easily discernible boundaries which used natural landmarks rather than idealized shapes.

= Rituals and Cosmological Symbolism

== Luk Nimit and the Central Stone
#align(center)[#image("../images/sima_p1_i1.jpeg", width: 80%)]

In the modern Thai tradition, *luk nimit* (round stones) are buried in sets of nine, eight directly under sema and one in the centre of the ubosot. Luk nimit have never been found in association with Dvaravati period sema from the Khorat Plateau. It seems clear therefore, that this tradition came in later, perhaps as early as the Sukhothai period.

The Vinayamukha author writes that the material to be used as nimitta must be prepared before. He prefers stones of larger size, large enough so that they are difficult to move. Round stones placed in pits are reasonable. He mentions that in ancient monasteries in Kamphaeng Phet and Sukhothai, very large sīmā-markers fixed on the ground were used.

Following the Thai tradition, on an astrologically auspicious day, these luk nimit stones are lowered into the pits. The central, ninth stone is buried with the highest level of ceremony, often suspended by ropes and dropped into the central pit by cutting a ribbon with a ceremonial knife. This central stone, acting as a symbolic seed, is buried alongside precious woods, coins, jewelry, and written prayers to permanently seal the spiritual center of the temple. In Cambodia, this stone is specifically identified as the indakhīla (Indra’s stake), marking the “navel” of the consecrated area.

== The Cosmic Mandala
#align(center)[#image("../images/sima_p1_i1.jpeg", width: 80%)]

In Southeast Asian traditions, the commentarial eight-directions model is strictly followed. The central luk nimit stone represents the Buddha. Each direction is then ritually mapped to one of the first-generation disciples of the Buddha:
- *East*: Ven. Aññā Koṇḍañña
- *South East*: Ven. Mahā Kassapa
- *South*: Ven. Sāriputta
- *South West*: Ven. Upāli
- *West*: Ven. Ānanda
- *North West*: Ven. Gavampati
- *North*: Ven. Moggallāna
- *North East*: Ven. Rāhula

This eight-directions mandala is a form of cosmological protective symbolism (similar to a maṇḍala or yantra) used by ritual specialists when laying out temple grounds.

== Rituals and Merit
It is believed that anyone who makes merit by burying a luk nimit stone will receive six kinds of blessings, including freedom from illness, wealth, and a long life. It is also customary to place a notebook, a pencil, a needle, and thread into the pit to grant good memory, sharp wisdom, and continuous progress.

= Religious Syncretism and Evolution

== Śaiva–Buddhist Encounters
Medieval India (6th-13th century) saw Tantric Śaivism and Tantric (Vajrayāna) Buddhism flourish in parallel, borrowing ritual structures, mantras, and iconographic forms from each other.

In the Śaiva tradition of temple consecration (*pratiṣṭhā*), the central act is the installation of the liṅga over a *garbhanyāsa* (womb deposit) consisting of gems, gold, and seeds. The Khmer sīmā ritual mirrors this template closely: directional altars, offerings cast into pits, and a central stone (*indakhīla*) buried beneath the main Buddha image. Both systems share the logic of ritually pacifying the land through buried offerings before fixing a sacred boundary.

== The Water-Splashing Sīmā (Udakukkhepa Sīmā)
Udakukkhepa sīmā refers to a temporary boundary in a body of water (rivers, sea, ponds). It is a type of natural *abaddha sīmā* (not-tied-off territory) determined by splashing water all around. The Dhammayuttika Nikāya initially favored this method for ordinations because natural bodies of water are inherently pure and free from technical disputes.

== Land Monks vs. Water Monks
A historical dispute occurred between those favoring water boundaries and those using land boundaries. This was resolved under King Rama V, who standardized land boundaries (*baddha sīmā*). The practice of *daḷhīkamma* (strengthening ceremony/re-ordination in water) ceased to be standard around the 1940s in Thailand.

= Modern Perspectives

== Suan Mokkh and Buddhadāsa Bhikkhu
Buddhadāsa Bhikkhu rejected the traditional roofed *uposot*, choosing instead a natural hilltop. He also rejected the *luk nimit* ceremony, viewing it as a tool for fundraising rather than a monastic necessity, opting for plain, unworked natural stones.

== Conclusion
The history of the *sīmā* shows a tension between long-established traditions and the return to original canonical principles. While royal temples often follow elaborate rituals, smaller monasteries have more freedom to use natural landmarks, reflecting a balance between cultural heritage and the original spirit of the Vinaya.

#pagebreak()

= Glosario de Términos

/ Sīmā: Límite o frontera consagrada que define el territorio donde se pueden realizar actos formales de la Saṅgha.
/ Nimitta: Marcador o señal la física utilizada para delimitar la sīmā (rocas, árboles, ríos, etc.).
/ Saṅghakamma: Actos legales o ceremonias eclesiásticas realizados por la comunidad monástica.
/ Uposatha: Sala de ordenación o el día de observancia donde se reúnen los monjes.
/ Baddha Sīmā: Límite "atado" o fijado permanentemente mediante un ritual formal.
/ Udakukkhepa Sīmā: Límite establecido mediante la salpicadura de agua, generalmente en ríos o lagos.
/ Visuṅgāma Sīmā: Territorio separado de los asentamientos civiles.
/ Luk Nimit: Piedras redondas consagradas que sirven como marcadores modernos en Tailandia.
/ Kammavācā: El texto formal o moción recitada durante los actos de la Saṅgha.
/ Upasampadā: El acto de ordenación completa de un monje.
/ Daḷhīkamma: Ceremonia de "fortalecimiento" para asegurar la validez de una ordenación previa.
/ Nimitta Mahābaddha-Sīmā: Grandes marcadores de límites que encierran todo un monasterio.
/ Vimativinodanī: Importante subcomentario del Vinaya compuesto en la India del Sur.
/ Samanatapāsādikā: El comentario principal del Vinaya escrito por Buddhaghosa.

#v(2em)


@ron_ajahn_nodate

@noauthor_bhikkhu_nodate

@opentipitaka_comentario_nodate-4

@opentipitaka_cronicas_nodate

#bibliography("My Library.bib",style: "ieee", title: "Bibliografía")



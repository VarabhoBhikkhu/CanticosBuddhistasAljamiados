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
#let color-titulo = rgb("#C58E00")
#let color-resaltado = rgb("#AD7121")
#let color-texto = rgb("#5A5D5A")
#let color-fondo-quote = rgb("#EFEFEF")
#let color-acento = color-resaltado


// ---------- Página ----------
#set page(
  width: 148mm, height: 210mm,      // A5
  margin: (inside: 18mm, outside: 14mm, top: 20mm, bottom: 18mm),
)
#set text(font: f-texto, size: 10.5pt, fill: color-texto, lang: "es")
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
  #text(font:"Alegreya Sans",weight: "regular", size: 14pt)[#pali] \
  #align(right)[#text(font: "Syamsiah Arabic",style: "italic", fill: luma(28.2%), size: 14pt)[#es]]
]

// Solo Pāli (p. ej. vespertinos, donde pali y español están en páginas enfrentadas)pl
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
//  PORTADA
// ============================================================
#set page(header: none, numbering: none, margin: 0pt)

#place(center + horizon)[
  #image("../images/BuddhaFondo.jpg", width: 100%, height: 100%, fit: "cover")
]
#place(left + horizon, dx: 30mm)[
  #text(font: f-sans, size: 32pt, weight: "bold", fill: white)[Cánticos Buddhistas]
]
#pagebreak()

// RESTABLECER MÁRGENES PARA EL RESTO DEL DOCUMENTO
#set page(margin: (inside: 18mm, outside: 14mm, top: 20mm, bottom: 18mm))

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
#pl("[हन्द मयम् बुद्धभित्थुतिं करोमसे]", "Cantemos ahora en elogio al Buddha.")
#pl("यो सो तथागतो अरहं सम्मासम्बुद्धो", "El Tathāgata es puro y perfectamente iluminado.")
#pl("विज्जाचरण-सम्पन्नो", "Impecable en conducta y comprensión,")
#pl("सुगतो", "Realizado,")
#pl("लोकविदू", "Conocedor de los mundos.")
#pl("अनुत्तरो पुरिसदम्म-सारथि", "Él entrena perfectamente a aquellos que desean entrenarse.")
#pl("सत्था देव-मनुस्सानं", "Él es Maestro de dioses y humanos.")
#pl("बुद्धो भगवा", "Él es despierto y sagrado.")
#pl("यो इमं लोकं सदेवकं समाराकं सब्रह्मकं", "En este mundo con sus dioses, demonios y espíritus gentiles,")
#pl("सस्समणं-ब्राह्मणिं पजं सदेव-मनुस्सं सयं अभिञ्ञा सच्चिकतवा पवेदेसि", "Sus buscadores y sabios, seres celestiales y humanos, Él reveló la verdad a través de una comprensión profunda.")
#pl("यो धम्मं देसेसि आदि-कल्याणं मज्झे-कल्याणं परियोसान-कल्याणं", "Él explicó el Dhamma: Sublime al principio, Sublime en el medio y Sublime al final.")
#pl("सात्थं सब्यञ्जनं केवल-परिपुण्णं परिसुद्धं ब्रह्म-चरियं पकासेसि", "Él explicó la vida espiritual de completa pureza, En su esencia y convenciones.")
#pl("तम्-अहं भगवन्तं अभिपुजयामि तम्-अहं भगवन्तं सिरसा नमामि", "Yo canto mi elogio al Buddha, yo saludo respetuosamente al Excelso.")

== Homenaje al Dhamma
#pl("[Handa mayaṁ dhammābhitthutiṁ karomase]", "Cantemos ahora en elogio al Dhamma")
#pl("Yo so svākkhāto bhagavatā dhammo", "El Dhamma, tan bien explicado por el Excelso,")
#pl("Sandiṭṭhiko", "Presente aquí y ahora,")
#pl("Akāliko", "Intemporal,")
#pl("Ehipassiko", "Incentivando a investigar,")
#pl("Opanayiko", "Guiando al interior,")
#pl("Paccattaṁ veditabbo viññūhi", "Para ser experimentado individualmente por los sabios.")
#pl("Tam-ahaṁ dhammaṁ abhipūjayāmi tam-ahaṁ dhammaṁ sirasā namāmi", "Yo canto mi elogio a estas enseñanzas, yo saludo respetuosamente esta verdad.")
#rev

== Homenaje a la Saṅgha
#pl("[Handa mayaṁ saṅghābhitthutiṁ karomase]", "Cantemos ahora en elogio a la Saṅgha.")
#pl("Yo so supaṭipanno bhagavato sāvakasaṅgho", "Son los discípulos del Maestro que practicaron correctamente,")
#pl("Ujupaṭipanno bhagavato sāvakasaṅgho", "Que practicaron directamente,")
#pl("Ñāyapaṭipanno bhagavato sāvakasaṅgho", "Que practicaron con reflexión,")
#pl("Sāmīcipaṭipanno bhagavato sāvakasaṅgho", "Aquellos que practicaron con integridad —")
#pl("Yadidaṁ cattāri purisayugāni aṭṭha purisapuggalā", "Es decir, los cuatro pares, los ocho tipos de Seres Nobles —")
#pl("Esa bhagavato sāvakasaṅgho", "Estos son los discípulos del Maestro.")
#pl("Āhuneyyo", "Tales discípulos son merecedores de presentes,")
#pl("Pāhuneyyo", "Merecedores de hospitalidad,")
#pl("Dakkhiṇeyyo", "Merecedores de ofrendas,")
#pl("Añjali-karaṇīyo", "Merecedores de respeto;")
#pl("Anuttaraṁ puññakkhettaṁ lokassa", "Ellos promueven el surgir de un bien incomparable en el mundo.")
#pl("Tam-ahaṁ saṅghaṁ abhipūjayāmi tam-ahaṁ saṅghaṁ sirasā namāmi", "Yo canto mi elogio a esta Saṅgha, yo saludo respetuosamente a esta Saṅgha.")
#rev

== Saludo a la Joya Triple
#pl("[Handa mayaṁ ratanattaya-paṇāma-gāthāyo c’eva saṁvega-parikittana-pāṭhañca bhaṇāmase]", "Cantemos ahora nuestro saludo a la Joya Triple y los versos que estimulan el sentido de urgencia.")
#pl("Buddho susuddho karuṇā-mahaṇṇavo", "El Buddha absolutamente puro, con compasión como el Océano,")
#pl("Yo’ccanta-suddhabbara-ñāṇa-locano", "Poseyendo la visión clara de Sabiduría,")
#pl("Lokassa pāpūpakilesa-ghātako", "Destructor de los defectos mundanos")
#pl("Vandāmi buddhaṁ aham-ādarena taṁ", "En plena devoción, ese Buddha yo venero.")
#pl("Dhammo padīpo viya tassa satthuno", "Las enseñanzas del Maestro, como una lámpara,")
#pl("Yo magga-pākāmata-bheda-bhinnako", "Iluminan el camino y su fruto: la Realidad Inmortal,")
#pl("Lokuttaro yo ca tad-attha-dīpano", "Aquello que está más allá del mundo condicionado")
#pl("Vandāmi dhammaṁ aham-ādarena taṁ", "En plena devoción, ese Dhamma yo venero.")
#pl("Saṅgho sukhettābhyati-khetta-saññito", "La Saṅgha, el mejor terreno para el cultivo,")
#pl("Yo diṭṭha-santo sugatānubodhako", "Aquellos que realizaron la paz, despertando después del Maestro,")
#pl("Lolappahīno ariyo sumedhaso", "Nobles y Sabios, habiendo abandonado todo anhelo,")
#pl("Vandāmi saṅghaṁ aham-ādarena taṁ", "En plena devoción, esa Saṅgha yo venero.")
#pl("Iccevam-ekantabhipūja-neyyakaṁ vatthuttayaṁ vandayatābhisaṅkhataṁ", "Este saludo debe ser hecho a lo que tiene valor.")
#pl("Puññaṁ mayā yaṁ mama sabbupaddavā mā hontu ve tassa pabhāva-siddhiyā", "A través del poder de esta acción benéfica, que todos los obstáculos puedan ser vencidos.")
#pl("Idha tathāgato loke uppanno arahaṁ sammāsambuddho", "Aquel que conoce las cosas como son, vino a este mundo y es un Arahant, un ser perfectamente despierto.")
#pl("Dhammo ca desito niyyāniko upasamiko parinibbāniko sambodhagāmī sugatappavedito", "Purificando la vía que libera de la ilusión, tranquilizando y dirigiéndose hacia la paz perfecta, guiando a la Iluminación: Este Camino Él dió a conocer.")
#pl("Mayan-taṁ dhammaṁ sutvā evaṁ jānāma", "Habiendo oído las Enseñanzas sabemos lo siguiente:")
#pl("Jātipi dukkhā", "El nacimiento es dukkha,")
#pl("Jarāpi dukkhā", "El envejecimiento es dukkha,")
#pl("Maraṇampi dukkhaṁ", "La muerte es dukkha;")
#pl("Soka-parideva-dukkha-domanass’upāyāsāpi dukkhā", "Tristeza, lamentación, dolor, angustia y desespero son dukkha;")
#pl("Appiyehi sampayogo dukkho", "Asociación con lo que no gusta es dukkha;")
#pl("Piyehi vippayogo dukkho", "Separación de lo que gusta es dukkha;")
#pl("Yamp’icchaṁ na labhati tampi dukkhaṁ", "No alcanzar aquello que se quiere es dukkha.")
#pl("Saṅkhittena pañcupādānakkhandhā dukkhā", "Resumiendo, las cinco khandhas son dukkha.")
#pl("Seyyathīdaṁ", "Estas son:")
#pl("Rūpūpādānakkhandho", "Apego a la forma,")
#pl("Vedanūpādānakkhandho", "Apego a la sensación,")
#pl("Saññūpādānakkhandho", "Apego a la percepción,")
#pl("Saṅkhārūpādānakkhandho", "Apego a las formaciones mentales,")
#pl("Viññāṇūpādānakkhandho", "Apego a la cognición.")
#pl("Yesaṁ pariññāya", "Para esta total comprensión,")
#pl("Dharamāno so bhagavā evaṁ bahulaṁ sāvake vineti", "Durante su vida, el Excelso instruyó frecuentemente así a sus discípulos.")
#pl("Evaṁ bhāgā ca panassa bhagavato sāvakesu anusāsanī bahulā pavattati", "Más allá de eso, Él instruyó:")
#pl("Rūpaṁ aniccaṁ", "La forma es impermanente,")
#pl("Vedanā aniccā", "La sensación es impermanente,")
#pl("Saññā aniccā", "La percepción es impermanente,")
#pl("Saṅkhārā aniccā", "Las formaciones mentales son impermanentes,")
#pl("Viññāṇaṁ aniccaṁ", "La cognición es impermanente;")
#pl("Rūpaṁ anattā", "La forma no es ‘yo’,")
#pl("Vedanā anattā", "La sensación no es ‘yo’,")
#pl("Saññā anattā", "La percepción no es ‘yo’,")
#pl("Saṅkhārā anattā", "Las formaciones mentales no son ‘yo’,")
#pl("Viññāṇaṁ anattā", "La cognición no es ‘yo’;")
#pl("Sabbe saṅkhārā aniccā", "Ninguna condición es permanente,")
#pl("Sabbe dhammā anattā’ti", "No hay un ‘yo’ en lo creado o lo increado.")
#pl("Te mayaṁ otiṇṇāmha jātiyā jarā-maraṇena", "Todos nosotros nos vemos arrastrados por el nacimiento, el envejecimiento y la muerte,")
#pl("Sokehi paridevehi dukkhehi domanassehi upāyāsehi", "Por la tristeza, lamentación, dolor, angustia y desespero,")
#pl("Dukkhotiṇṇā dukkha-paretā", "Arrastrados por dukkha y obstruidos por dukkha.")
#pl("Appeva nāmimassa kevalassa dukkha-kkhandhassa antakiriyā paññāyethā’ti", "Que alcancemos el fin de toda esta masa de sufrimiento.")
#nota("La parte que sigue es cantada solamente por los monjes.")
#pl("Cira-parinibbutampi taṁ bhagavantaṁ uddissa arahantaṁ sammāsambuddhaṁ", "Recordando al Excelso, el Noble Maestro, el Perfectamente Iluminado, que hace mucho alcanzó el Parinibbāna,")
#pl("Saddhā agārasmā anagāriyaṁ pabbajitā", "Partimos con confianza del hogar hacia la vida monástica.")
#pl("Tasmiṁ bhagavati brahma-cariyaṁ carāma", "Así como el Iluminado, practicamos la Vida Sagrada,")
#pl("Bhikkhūnaṁ sikkhāsājīva-samāpannā", "Completamente equipados con el sistema de entrenamiento de los Bhikkhus.")
#pl("Taṁ no brahma-cariyaṁ imassa kevalassa dukkha-kkhandhassa antakiriyāya saṁvattatu", "Que esta vida purificada pueda conducirnos al término de toda esta masa de sufrimiento.")
#nota("Una versión alternativa de la sección anterior, que puede ser también cantada por los laicos.")
#pl("Cira-parinibbutampi taṁ bhagavantaṁ saraṇaṁ gatā", "El Excelso, aunque hace tiempo alcanzó el Parinibbāna, es nuestro refugio.")
#pl("Dhammañca saṅghañca", "Así como el Dhamma y la Saṅgha.")
#pl("Tassa bhagavato sāsanaṁ yathā-sati yathā-balaṁ manasikaroma anupaṭipajjāma", "Seguimos el camino de aquel Excelso, atentamente con toda nuestra fuerza y conciencia.")
#pl("Sā sā no paṭipatti Imassa kevalassa dukkha-kkhandhassa antakiriyāya saṁvattatu", "Que el cultivo de esta práctica pueda conducirnos al término de toda esta masa de sufrimiento.")

== Homenaje de Cierre
#pl("[Arahaṁ] sammāsambuddho bhagavā", "Al Maestro, el perfectamente Iluminado y Excelso")
#pl("Buddhaṁ bhagavantaṁ abhivādemi", "Al Buddha, el Excelso, yo rindo homenaje.")
#rev

#pl("[Svākkhāto] bhagavatā dhammo", "A las Enseñanzas, tan bien explicadas por Él")
#pl("Dhammaṁ namassāmi", "Al Dhamma, yo rindo homenaje.")
#rev

#pl("[Supaṭipanno] bhagavato sāvakasaṅgho", "A los discípulos del Excelso que tan bien practicaron")
#pl("Saṅghaṁ namāmi", "A la Saṅgha, yo rindo homenaje.")
#rev  
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
#pl("[Arahaṁ] sammāsambuddho bhagavā", "Al Maestro, el perfectamente Iluminado y Excelso")
#pl("Buddhaṁ bhagavantaṁ abhivādemi", "Al Buddha, el Excelso, yo rindo homenaje.")
#rev

#pl("[Svākkhāto] bhagavatā dhammo", "A las Enseñanzas, tan bien explicadas por Él")
#pl("Dhammaṁ namassāmi", "Al Dhamma, yo rindo homenaje.")
#rev

#pl("[Supaṭipanno] bhagavato sāvakasaṅgho", "A los discípulos del Excelso que tan bien practicaron")
#pl("Saṅghaṁ namāmi", "A la Saṅgha, yo rindo homenaje.")
#rev


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
#pl("Yassa saddhā tathāgate acalā supatiṭṭhitā", "Aquél cuya confianza en el Tathāgata es inquebrantable y establecida bien,")
#pl("Sīlañca yassa kalyāṇaṁ ariya-kantaṁ pasaṁsitaṁ", "cuya virtud es admirable, tiene el regocijo y elogio de los Nobles.")

#pl("Saṅghe pasādo yass’atthi uju-bhūtañca dassanaṁ", "Aquél que tiene confianza en la Saṅgha, que ve directamente la verdadera realidad,")
#pl("Adaliddo’ti taṁ āhuamoghaṁ tassa jīvitaṁ", "de él se dice que no es ‘pobre’ y que en vano no es su vida.")

#pl("Tasmā saddhañca sīlañca pasādaṁ dhamma-dassanaṁ", "Por ello, a la virtud y a la fe, a la confianza y al saber de la verdad —")
#pl("Anuyuñjetha medhāvīsaraṁ buddhāna sāsanaṁ", "a esto los sabios se deben dedicar, manteniendo las enseñanzas de Buddha en la mente.")



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

=== La Reverencia y posturas
Inclinarse, o postrarse ante lo que uno considera digno del mayor respeto, ya sean mayores o maestros, objetos o lugares sagrados, es una costumbre milenaria de la cultura budista y una de las muchas y hermosas formas de etiqueta budista. 

Realizada de forma correcta y consciente, la postración no es solo un ritual vacío que implica rebajarse ante imágenes religiosas por una aceptación ciega de la costumbre. Más bien, es una forma de mostrar fe, respeto y gratitud hacia aquello que es verdaderamente digno de tal veneración. Además, es un acto de humildad, una cualidad que es a la vez una bendición para los demás y que inclina la propia mente hacia los ideales y aspiraciones espirituales que esos objetos representan. Inclinarse ante la Triple Joya es elevar el propio corazón y la propia mente.

La forma y el método correctos para hacer la postración son los siguientes:

==== La reverencia o postración de los cinco puntos
El término ‘postración de cinco puntos’ se refiere a los cinco puntos del cuerpo que hacen contacto con el suelo cuando se realiza una postración. Son: la frente, ambos codos y ambas rodillas.

*Postura preparatoria de la Reverencia:*
- *Hombres*: se arrodillan en cuclillas con las palmas de ambas manos apoyadas en los muslos.
- *Mujeres*: adoptan la misma postura, pero con el empeine de los pies hacia el suelo.

==== El ‘Añjali’
Junte las palmas de las manos a la altura del pecho, apuntando hacia arriba en un ángulo de cuarenta y cinco grados con los dedos juntos.

==== El ‘Vandana’
Lleve el añjali (palmas juntas) hasta la frente de modo que los pulgares se coloquen entre las cejas y las puntas de los dedos índice estén en la línea del cabello.
- *Hombres*: mantienen la cabeza recta.
- *Mujeres*: inclinan la cabeza ligeramente hacia adelante.

==== El ‘Abhivada’
Manteniendo la espalda recta, inclínese llevando la frente al suelo de modo que toque el espacio entre las palmas (aproximadamente a una distancia de un palmo), que ahora estarán boca abajo, planas sobre el suelo.
- *Hombres*: mantienen los codos y las rodillas alineados y tocándose.
- *Mujeres*: colocan los codos a cada lado de las rodillas.

=== Postura ‘papiyap’ (พับเพียบ)
‘พับเพียบ’ (pronunciado ‘papiyap’) es un término tailandés que se refiere a la postura tradicional que se adopta al cantar. Sentarse ‘papiyap’ significa sentarse con las piernas dobladas a un lado. La postura de piernas cruzadas o ‘loto’ se reserva para la práctica formal de meditación. 

Sentarse con las piernas o los pies apuntando hacia una imagen de Buddha o hacia los monásticos se considera irrespetuoso, ya que los pies son la parte más baja del cuerpo. Por lo tanto, ‘papiyap’ es una postura apropiada para asumir mientras se canta. Sin embargo, cuando se cantan los versos de homenaje a la Triple Joya, uno se arrodilla sobre sus talones.

- *Hombres*: se sientan con una pierna doblada a un lado y la otra pierna cruzada frente a ellos, con la planta del pie tocando la rodilla.
- *Mujeres*: se sientan con una pierna doblada a un lado, pero con la otra pierna doblada debajo de ellas, manteniendo las rodillas juntas.

==== Cambio de postura
No está mal cambiar de postura cuando el dolor se agudiza, pero debe hacerse de manera educada. La mejor manera de cambiar de postura, ya sea sentado en meditación o mientras se canta, es cambiar la posición de las piernas desde atrás, inclinándose hacia adelante y usando una mano en el suelo para apoyarse.

=== Etiqueta general en el monasterio y la sala de meditación
El monasterio y, en particular, la sala principal de meditación son un espacio sagrado. La sala de meditación (sala Uposatha) debe proporcionar siempre un entorno adecuado y propicio para la práctica de virtud, meditación y desarrollo de sabiduría.

Al entrar en la sala principal, observe las siguientes prácticas:

+ Si es necesario hablar con alguien, es mejor salir a hacerlo. O al menos hágalo lo más silenciosa y brevemente posible.
+ No se permiten sombreros, capuchas, gorros, zapatos, comida ni bebidas en la sala.
+ Se agradecería que los padres con bebés o niños pequeños sacaran a sus hijos de la sala si empiezan a llorar o a comportarse de forma incontrolable.
+ Solo se pueden tomar fotos y vídeos con el permiso directo del monje de mayor antigüedad.
+ El monasterio es un lugar de celibato. Se debe evitar cualquier forma de contacto físico inadecuado con el sexo opuesto en los terrenos del monasterio.
+ Al entrar al monasterio, evite cualquier tipo de ropa que sea reveladora o inmodesta.
+ Por favor, no se siente apuntando con los pies hacia el altar ni hacia los monjes.
+ Por favor, no suba a la plataforma elevada frente al altar principal; es un espacio reservado solo para la Saṅgha monástica.
+ Todos los teléfonos móviles o dispositivos eléctricos que puedan hacer ruido deben dejarse fuera de la sala o apagarse.
+ Estas normas se aplican a cualquier edificio del monasterio donde se celebren discursos de Dhamma o se practique la meditación.

Una actitud básica de moderación y respeto es todo lo que se necesita. Gracias.
== Glosario de términos en Pāli
/ Anatta: Literalmente, ‘no-yo’, i.e. impersonal, sin esencia individual; ni persona ni perteneciente a persona. Una de las tres características de todo fenómeno condicionado.

#gl("Anatta", "Literalmente, ‘no-yo’, i.e. impersonal, sin esencia individual; ni persona ni perteneciente a persona. Una de las tres características de todo fenómeno condicionado.")
#gl("Anicca", "No permanente, inestable, de la naturaleza de aparecer y extinguirse. Una de las tres características de todo fenómeno condicionado.")
#gl("Arahaṁ/Arahant", "Literalmente, ‘el que se lo merece’ — un término aplicado a todos los seres iluminados.")
#gl("Ariyapuggalā", "‘Seres Nobles’ o ‘Nobles Discípulos’ — existen ocho tipos: aquellos que trabajan por alcanzar o aquellos que han alcanzado los cuatro diferentes niveles de la iluminación.")
#gl("Bhagavā", "Epíteto reservado al Señor Buddha.")
#gl("Bhikkhu", "Un monje budista que vive como monje mendicante, siguiendo 227 preceptos de entrenamiento que definen una vida de renuncia y simplicidad.")
#gl("Brahmā", "Ser celestial; un dios en uno de los más altos reinos espirituales.")
#gl("Buddha", "‘El que despierta’, uno que conoce las cosas como son; un potencial que existe en todo ser humano. El último Buddha conocido, Siddhattha Gotama, vivió y enseñó en la India en V a.C.")
#gl("Deva", "Ser celestial. Menos refinado que brahmā; parecido al concepto de ‘Ángel de la guarda’. ")
#gl("Dhamma", "(Sánscrito: Dharma) Las enseñanzas de Buddha contenidas en las escrituras, no como dogma de fe, más como una balsa o vehículo que lleva al discípulo hasta la liberación. También, significa la Verdad a la que se refieren las enseñanzas. Cuando se escribe como ‘dhamma’, i.e. con ‘d’ minúscula, se refiere a ‘cosa’ o ‘elemento’.")
#gl("Dukkha", "Literalmente, ‘difícil de soportar’ — mal-estar, inquietud mental, angustia, insatisfacción, des-contento, estrés, sufrimiento. Una de las tres características de los fenómenos condicionados.")
#gl("Vida Santa (brahmacariya)", "Literalmente: la conducta de Brahma; usualmente referido a la vida monástica. Usar este término implica voto de celibato.")
#gl("Jhāna", "Absorción mental. Estado de gran concentración enfocado en una simple sensación o noción mental.")
#gl("Kamma", "(Sánscrito: karma) Acción intencional; acciones creadas por impulso habitual, con intención.")
#gl("Khandhā", "Los cinco agregados que componen un ser, tanto fisicos como mentales — estos son: rūpa, vedanā, saññā, saṅkhārā, viññāṇa. Apego a cualquier de estos como ‘Esto es mio’, ‘Yo soy esto’ o ‘Esto es yo’.")
#gl("Māra", "Personificación de las fuerzas del mal. Durante la lucha de Buddha por la iluminación, Māra se manifestó tratando de desviarle de su meta.")
#gl("Nibbāna", "(Sánscrito: Nirvāṇa) Literalmente, ‘frescor’ — el estado de liberación de todo sufrimiento e impurezas, la meta del camino budista.")
#gl("Paccekabuddha", "Buddha solitario — alguien que se ilumina por sus propios medios sin depender de maestro alguno, pero que (a diferencia de Buddha) no posee discípulos.")
#gl("Paritta", "Versos cantados particularmente para bendiciones y protección.")
#gl("Parinibbāna", "El perecimiento definitivo de Buddha, i.e. entrada definitiva en Nibbāna.")
#gl("Puñña", "Mérito, acumulación de buena fortuna, bendiciones o bienestar resultante de la práctica del Dhamma.")
#gl("Rūpa", "Forma o materia. Los elementos físicos que componen el cuerpo, i.e. tierra, agua, fuego y aire (solidez, cohesión, temperatura y vibración).")
#gl("Saṅgha", "La comunidad de aquellos que practican el camino de Buddha. Más específicamente, aquellos que se comprometen formalmente al estilo de vida de monásticos mendicantes.")
#gl("Saṅkhārā", "Formaciones, construcciones, todas las cosas condicionadas, o impulsos voluntarios, es decir, todos los estados mentales con excepción de vedana y sañña, que le dan matiz a los pensamientos volviéndolos en ‘buenos’, ‘malos’ o ‘neutros’.")
#gl("Saññā", "Percepción, la función mental de reconocer. Impone valores a las cosas dependiendo de experiencias previas.")
#gl("Sati", "Este término proviene del verbosaratique significa ‘recordar’. ¿Recordar el qué? Recordar el objetivo de la práctica.")
#gl("Tathāgata", "‘Así ido’ o ‘Así venido’ — dando el sentido de ‘el que viene de vuelta de todo’ uno que ha ido más allá del sufrimiento y la muerte; uno que experimenta las cosas como realmente son, sin ilusión. El epíteto que Buddha se aplicó a sí mismo después de obtener la Iluminación perfecta.")
#gl("Joya Triple", "Buddha, Dhamma y Saṅgha.")
#gl("Vedanā", "Sensación — Sensaciones mentales o físicas ya sean agradables, desagradables o neutras.")
#gl("Viññāṇa", "Conciencia sensorial — proceso por el cual puede existir la visión, el oído, el olfato, el gusto, el tocar y el pensar.")

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

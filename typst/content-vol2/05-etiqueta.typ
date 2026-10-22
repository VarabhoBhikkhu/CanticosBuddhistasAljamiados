// =====================================================================
//  05-etiqueta.typ — «Etiqueta monástica» (capítulo apendicial)
//  Réplica de las páginas 91-95 de main-es-vol2.pdf
// =====================================================================

#import "../template-vol2.typ": *

// --- figura con dos imágenes y pies de foto ------------------------------
#let figura-doble(archivo1, archivo2, cap1, cap2, caparriba: false) = {
  if caparriba {
    if cap1 != none { align(center)[#text(size: 9pt)[#cap1]] }
  }
  grid(
    columns: (1fr, 1fr),
    column-gutter: 10pt,
    align: top + center,
    image("../../images/" + archivo1, width: 100%),
    image("../../images/" + archivo2, width: 100%),
  )
  if not caparriba {
    if cap1 != none { align(center)[#text(size: 9pt)[#cap1]] }
    if cap2 != none { align(center)[#text(size: 9pt)[#cap2]] }
  }
}

#capitulo[Etiqueta monástica]
#set text(size: 11pt)
#set par(leading: 17pt, spacing: 9pt, justify: false)

#seccion[La Reverencia y posturas]

Inclinarse, o postrarse ante lo que uno considera digno del mayor respeto, ya sean mayores o maestros, objetos o lugares sagrados, es una costumbre milenaria de la cultura budista y una de las muchas y hermosas formas de etiqueta budista.

Realizada de forma correcta y consciente, la postración no es solo un ritual vacío que implica rebajarse ante imágenes religiosas por una aceptación ciega de la costumbre. Más bien, es una forma de mostrar fe, respeto y gratitud hacia aquello que es verdaderamente digno de tal veneración. Además, es un acto de humildad, una cualidad que es a la vez una bendición para los demás y que inclina la propia mente hacia los ideales y aspiraciones espirituales que esos objetos representan. Inclinarse ante la Triple Joya es elevar el propio corazón y la propia mente.

La forma y el método correctos para hacer la postración son los siguientes:

#subseccion[La reverencia o postración de los cinco puntos]

El término ‘postración de cinco puntos’ se refiere a los cinco puntos del cuerpo que hacen contacto con el suelo cuando se realiza una postración. Son: la frente, ambos codos y ambas rodillas.

#subseccion[La postura preparatoria de la Reverencia:]

#figura-doble(
  "prep-man-ai.jpg",
  "prep-woman-ai.jpg",
  [Los hombres se arrodillan en cuclillas con las palmas de ambas manos apoyadas en los muslos.],
  [Las mujeres adoptan la misma postura, pero con el empeine de los pies hacia el suelo.],
  caparriba: true,
)

#subseccion[El ‘Añjali’]

Junte las palmas de las manos a la altura del pecho, apuntando hacia arriba en un ángulo de cuarenta y cinco grados con los dedos juntos.

#figura-doble("anjali-man-ai.jpg", "anjali-woman-ai.jpg", none, none)

#subseccion[El ‘Vandana’]

Lleve el añjali (palmas juntas) hasta la frente de modo que los pulgares se coloquen entre las cejas y las puntas de los dedos índice estén en la línea del cabello.

#figura-doble(
  "vandana-man-ai.jpg",
  "vandana-woman-ai.jpg",
  [Los hombres mantienen la cabeza recta.],
  [Las mujeres inclinan la cabeza ligeramente hacia adelante.],
)

#subseccion[El ‘Abhivada’]

Manteniendo la espalda recta, inclínese llevando la frente al suelo de modo que toque el espacio entre las palmas (aproximadamente a una distancia de un palmo), que ahora estarán boca abajo, planas sobre el suelo.

#figura-doble(
  "abhivada-man-ai.jpg",
  "abhivada-woman-ai.jpg",
  [Los hombres mantienen los codos y las rodillas alineados y tocándose.],
  [Las mujeres colocan los codos a cada lado de las rodillas],
)

#subseccion[#thai[พับเพียบ] ‘papiyap’]

#thai[‘พับเพียบ’] (pronunciado ‘papiyap’) es un término tailandés que se refiere a la postura tradicional que se adopta al cantar. Sentarse ‘papiyap’ significa sentarse con las piernas dobladas a un lado, como se muestra en el diagrama a continuación. La postura de piernas cruzadas o ‘loto’ se reserva para la práctica formal de meditación. Sentarse con las piernas o los pies apuntando hacia una imagen de Buddha o hacia los monásticos se considera irrespetuoso, ya que los pies son la parte más baja del cuerpo. Por lo tanto, ‘papiyap’ es una postura apropiada para asumir mientras se canta. Sin embargo, cuando se cantan los versos de homenaje a la Triple Joya (Sección 1-Vol. 1), uno se arrodilla sobre sus talones.

#figura-doble(
  "papiap-man-ai.jpg",
  "papiap-woman-ai.jpg",
  [Los hombres se sientan con una pierna doblada a un lado y la otra pierna cruzada frente a ellos, con la planta del pie tocando la rodilla.],
  [Las mujeres se sientan con una pierna doblada a un lado, pero con la otra pierna doblada debajo de ellas, manteniendo las rodillas juntas.],
)

#subseccion[Cambio de postura]

No está mal cambiar de postura cuando el dolor se agudiza, pero debe hacerse de manera educada. La mejor manera de cambiar de postura, ya sea sentado en meditación o mientras se canta, es cambiar la posición de las piernas desde atrás, inclinándose hacia adelante y usando una mano en el suelo para apoyarse.

#pagebreak()

#seccion[Etiqueta general en el monasterio y la sala de meditación]

El monasterio y, en particular, la sala principal de meditación son un espacio sagrado. La sala de meditación (sala Uposatha) debe proporcionar siempre, tanto a la comunidad monástica como a la laica, un entorno adecuado y propicio para la práctica de virtud, meditación y desarrollo de sabiduría. Hay ciertos tipos de comportamiento que contribuyen a una atmósfera de buena práctica espiritual y reflexión tranquila, y otros tipos de comportamiento que pueden destruirla rápidamente. Por lo tanto, es importante que cualquier persona que entre en el monasterio y, por extensión, en la sala de meditación, sea considerada respecto a cómo su comportamiento puede estar afectando a quienes le rodean. Esto beneficiará tanto a la propia práctica de Sati, como al entorno del monasterio en su conjunto.

Cuando entre en la sala principal, observe las siguientes prácticas:

#lista[
  Si es necesario hablar con alguien, es mejor salir a hacerlo. O al menos hágalo lo más silenciosa y brevemente posible, para no molestar a las personas a su alrededor que podrían estar tratando de meditar.
  No se permiten sombreros, capuchas, gorros, zapatos, comida ni bebidas (incluidas botellas de agua) en la sala.
  Se agradecería que los padres con bebés o niños pequeños sacaran a sus hijos de la sala si empiezan a llorar o a comportarse de forma incontrolable durante las sesiones de meditación y discursos de Dhamma.
  Solo se pueden tomar fotos y vídeos con el permiso directo del monje de mayor antigüedad.
  El monasterio es un lugar de celibato. La separación de sexos se practica estrictamente durante los retiros de meditación, y se debe evitar cualquier forma de contacto físico inadecuado con el sexo opuesto en cualquier lugar de los terrenos del monasterio.
  Al entrar al monasterio, las personas deben evitar cualquier tipo de ropa que sea reveladora o inmodesta.
  Por favor, no se siente apuntando con los pies hacia el altar ni hacia los monjes, ya que esto se considera una falta de respeto.
  Por favor, no suba a la plataforma elevada frente al altar principal. Es un espacio reservado solo para la Saṅgha monástica.
  Todos los teléfonos móviles o cualquier otro dispositivo eléctrico que pueda hacer ruido deben dejarse fuera de la sala o apagarse antes de entrar en ella.
  Estas normas se aplican no solo a la sala principal de meditación, sino a cualquier edificio del monasterio donde se celebren discursos de Dhamma o se practique la meditación.
]

Una actitud básica de moderación y respeto es todo lo que se necesita.

Gracias

# Libro de Cánticos - Proyecto Typst

Proyecto de conversión del **Libro de Cánticos (Pāli / Español)** de Publicaciones Sumedhārāma a **Typst**.

## Estructura del Proyecto

- `typst.toml`: Configuración del paquete y proyecto Typst.
- `template.typ`: Plantilla de diseño y maquetación para formato de libro A5 (márgenes, cabeceras, pies de página, tipografía, estilos de títulos).
- `vol1.typ`: Fuente Typst del Volumen I (*Cánticos Matinales y Vespertinos y Reflexiones*).
- `vol2.typ`: Fuente Typst del Volumen II (*Discursos, Parittas y Cánticos Funerarios*).
- `vol1.pdf` / `vol2.pdf`: Archivos PDF compilados.

## Requisitos

- [Typst](https://github.com/typst/typst) (versión 0.11 o superior).

## Compilación

Para compilar ambos volúmenes:

```bash
typst compile vol1.typ vol1.pdf
typst compile vol2.typ vol2.pdf
```

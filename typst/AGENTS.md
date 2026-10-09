# AGENTS.md

## Overview
This repository contains a Typst project converting the *Libro de Cánticos* (Pāli / Español) volumes 1 and 2 from Publicaciones Sumedhārāma.

## Key Commands
- Compile Volume I: `typst compile vol1.typ vol1.pdf`
- Compile Volume II: `typst compile vol2.typ vol2.pdf`

## Project Structure
- `typst.toml`: Project manifest and package metadata.
- `template.typ`: A5 book layout template (margins, running headers, footers, typography, headings).
- `vol1.typ` / `vol2.pdf`: Source and compiled output for Volumen I.
- `vol2.typ` / `vol2.pdf`: Source and compiled output for Volumen II.
- `convert.js`: Node.js utility script used to extract and structure text from original PDFs.

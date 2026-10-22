#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
verify_es_vol2.py — Compara el PDF generado con Typst y el original LaTeX.

    python helpers/verify_es_vol2.py [original.pdf] [typst.pdf]

Informa de:
  · número de páginas
  · texto de cada página (diff palabra a palabra)
  · fuentes y tamaños usados
  · posiciones de las líneas (delta vertical medio)
"""

import re
import sys
import unicodedata
from collections import Counter

import pymupdf

ORIG = sys.argv[1] if len(sys.argv) > 1 else "main-es-vol2.pdf"
NUEVO = sys.argv[2] if len(sys.argv) > 2 else "typst/main-es-vol2-typst.pdf"


def norm(t):
    t = unicodedata.normalize("NFC", t)
    t = t.replace("’", "'").replace("‘", "'")
    t = t.replace("“", '"').replace("”", '"')
    t = t.replace("–", "-").replace("—", "--").replace("−", "-")
    t = re.sub(r"\s+", " ", t)
    return t.strip()


def palabras(t):
    return [w for w in re.split(r"\s+", norm(t)) if w]


def lineas(pagina):
    """Devuelve [(y_baseline, x0, size, font, texto)] de la página."""
    res = []
    for b in pagina.get_text("rawdict")["blocks"]:
        if b["type"] != 0:
            continue
        for l in b["lines"]:
            for s in l["spans"]:
                if not s["chars"]:
                    continue
                txt = "".join(c["c"] for c in s["chars"])
                if not txt.strip():
                    continue
                res.append((
                    round(s["chars"][0]["origin"][1], 1),
                    round(s["bbox"][0], 1),
                    round(s["size"], 1),
                    s["font"],
                    txt,
                ))
    res.sort()
    return res


def resumen(doc, etiqueta):
    print("=" * 72)
    print("%s — %d páginas, %.1f × %.1f pt" % (
        etiqueta, doc.page_count, doc[0].rect.width, doc[0].rect.height))
    fuentes = Counter()
    for i in range(doc.page_count):
        for b in doc[i].get_text("dict")["blocks"]:
            if b["type"] != 0:
                continue
            for l in b["lines"]:
                for s in l["spans"]:
                    fuentes[(s["font"], round(s["size"], 1))] += len(s["text"])
    print("  fuentes:")
    for (f, s), n in fuentes.most_common(14):
        print("    %-30s %5.1f pt  %7d car." % (f, s, n))


def main():
    a = pymupdf.open(ORIG)
    b = pymupdf.open(NUEVO)

    resumen(a, "ORIGINAL (LaTeX)")
    resumen(b, "NUEVO (Typst)")

    print("=" * 72)
    print("Diferencias de texto por página")
    print("-" * 72)
    n = max(a.page_count, b.page_count)
    malas = 0
    for i in range(n):
        if i >= a.page_count:
            print("p%-4d SOBRA en el nuevo" % (i + 1)); malas += 1; continue
        if i >= b.page_count:
            print("p%-4d FALTA en el nuevo" % (i + 1)); malas += 1; continue
        pa = palabras(a[i].get_text())
        pb = palabras(b[i].get_text())
        if pa == pb:
            continue
        malas += 1
        sa, sb = set(pa), set(pb)
        faltan = [w for w in pa if w not in sb][:6]
        sobran = [w for w in pb if w not in sa][:6]
        print("p%-4d orig=%3d nue=%3d | faltan: %s | sobran: %s" % (
            i + 1, len(pa), len(pb),
            " ".join(faltan)[:52], " ".join(sobran)[:52]))
    print("-" * 72)
    print("páginas con texto distinto: %d de %d" % (malas, n))

    print("=" * 72)
    print("Delta vertical medio (línea base) en las páginas con texto igual")
    print("-" * 72)
    for i in range(min(a.page_count, b.page_count)):
        la, lb = lineas(a[i]), lineas(b[i])
        wa = [x[4] for x in la]
        wb = [x[4] for x in lb]
        if [norm(x) for x in wa] != [norm(x) for x in wb]:
            continue
        if len(la) != len(lb) or len(la) < 4:
            continue
        d = [lb[j][0] - la[j][0] for j in range(len(la))]
        dx = [lb[j][1] - la[j][1] for j in range(len(la))]
        mad = sum(abs(x) for x in d) / len(d)
        madx = sum(abs(x) for x in dx) / len(dx)
        if mad > 1.0 or madx > 1.0:
            print("p%-4d Δy medio=%6.2f  Δx medio=%6.2f  (n=%d)" % (i + 1, mad, madx, len(d)))


if __name__ == "__main__":
    main()

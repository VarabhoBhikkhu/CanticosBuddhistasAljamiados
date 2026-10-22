#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
tex2typst.py — Convierte el LaTeX del «Libro de Cánticos · Segundo Volumen»
(chapters/spanish/*.tex) a Typst, conservando la estructura semántica que usa
la maqueta original:

    \\chapter / \\part / \\firstline / \\clearpage
    \\begin{leader} \\begin{paritta} \\begin{twochants} \\begin{solotwochants}
    \\begin{onechants} \\begin{soloonechants} \\begin{description}
    \\soloinstr \\instr \\emph \\textit \\textbf \\tr \\prul \\sidepar \\hsp

Uso:
    python helpers/tex2typst.py chapters/spanish/suttas.tex typst/content-vol2/suttas.typ
"""

import re
import sys
from pathlib import Path

# --------------------------------------------------------------------------
# 1. Analizador de LaTeX (subconjunto suficiente para este libro)
# --------------------------------------------------------------------------

CMD_RE = re.compile(r"\\([A-Za-z@]+)\*?|\\([^A-Za-z@])")


class Node:
    __slots__ = ("kind", "value", "args", "children")

    def __init__(self, kind, value=None, args=None, children=None):
        self.kind = kind          # text | cmd | env | br | amp | other
        self.value = value
        self.args = args          # lista de ("opt"|"req", texto)
        self.children = children

    def __repr__(self):  # pragma: no cover - ayuda de depuración
        return "<%s %r>" % (self.kind, self.value)


def strip_comments(src):
    out = []
    for line in src.split("\n"):
        res, i, in_verb = [], 0, False
        while i < len(line):
            c = line[i]
            if c == "\\" and i + 1 < len(line):
                res.append(line[i:i + 2])
                i += 2
                continue
            if c == "%":
                break
            res.append(c)
            i += 1
        out.append("".join(res))
    return "\n".join(out)


def _read_group(src, i):
    """Lee un grupo {...} o [...] balanceado desde src[i]. Devuelve (contenido, i_siguiente)."""
    opener = src[i]
    closer = "}" if opener == "{" else "]"
    depth = 0
    j = i
    while j < len(src):
        c = src[j]
        if c == "\\":
            j += 2
            continue
        if c == opener:
            depth += 1
        elif c == closer:
            depth -= 1
            if depth == 0:
                return src[i + 1:j], j + 1
        j += 1
    return src[i + 1:], len(src)


def parse(src):
    """Convierte el código LaTeX en una lista de nodos."""
    nodes = []
    buf = []
    i = 0
    n = len(src)

    def flush():
        if buf:
            nodes.append(Node("text", "".join(buf)))
            buf.clear()

    while i < n:
        c = src[i]

        if c == "\\":
            m = CMD_RE.match(src, i)
            if not m:
                buf.append(src[i:i + 2])
                i += 2
                continue
            name = m.group(1)
            i = m.end()

            if name is None:                       # \% \\ \& ... escapes
                ch = m.group(2)
                if ch == "\\":
                    flush()
                    nodes.append(Node("br"))
                    continue
                if ch == "&":
                    flush()
                    nodes.append(Node("amp"))
                    continue
                buf.append("\\" + ch)
                continue

            if name == "begin":
                args = []
                j = i
                while j < n and src[j] in " \t\r\n":
                    j += 1
                env, j = _read_group(src, j)
                i = j
                inicio = i
                # busca el \end correspondiente
                depth, k = 1, i
                fin = len(src)
                while k < n and depth:
                    mm = CMD_RE.search(src, k)
                    if not mm:
                        break
                    if mm.group(1) == "begin":
                        depth += 1
                        k = mm.end()
                        continue
                    if mm.group(1) == "end":
                        depth -= 1
                        if depth == 0:
                            fin = mm.start()
                            j2 = mm.end()
                            while j2 < n and src[j2] in " \t\r\n":
                                j2 += 1
                            _env2, j2 = _read_group(src, j2)
                            i = j2
                            break
                        k = mm.end()
                        continue
                    k = mm.end()
                flush()
                nodes.append(Node("env", env, None, parse(src[inicio:fin])))
                continue

            if name == "end":
                j = i
                while j < n and src[j] in " \t\r\n":
                    j += 1
                _env, j = _read_group(src, j)
                i = j
                continue

            # argumentos opcionales y obligatorios
            args = []
            j = i
            while True:
                k = j
                while k < n and src[k] in " \t\r\n":
                    k += 1
                if k < n and src[k] == "[":
                    val, j = _read_group(src, k)
                    args.append(("opt", val))
                    continue
                if k < n and src[k] == "{":
                    val, j = _read_group(src, k)
                    args.append(("req", val))
                    continue
                break
            i = j
            flush()
            nodes.append(Node("cmd", name, args))
            continue

        if c in "{}":
            buf.append(c)
            i += 1
            continue

        if c == "&":  # separador de celdas en los cánticos
            flush()
            nodes.append(Node("amp"))
            i += 1
            continue

        buf.append(c)
        i += 1

    flush()
    return nodes


# --------------------------------------------------------------------------
# 2. Escape de texto para la sintaxis de Typst
# --------------------------------------------------------------------------

TYPST_SPECIAL = {
    "#": "\\#", "$": "\\$", "*": "\\*", "_": "\\_",
    "<": "\\<", ">": "\\>", "@": "\\@", "`": "\\`",
    "\\": "\\\\", "[": "\\[", "]": "\\]",
}


def esc(text):
    out = []
    for ch in text:
        out.append(TYPST_SPECIAL.get(ch, ch))
    return "".join(out)


# --------------------------------------------------------------------------
# 3. Emisión
# --------------------------------------------------------------------------

class Ctx:
    def __init__(self):
        self.macros = {}          # \renewcommand{\englishTitle}{...}
        self.pending = []         # marcadores pendientes de volcar
        self.part = 0             # contador de partes
        self.sub_indent = False   # ¿el próximo \chapter es sub-capítulo?
        self.in_leader = False

    def macro(self, name):
        return self.macros.get(name)


def _arg(args, kind="req", idx=0):
    got = [a for k, a in args if k == kind]
    return got[idx] if len(got) > idx else ""


def _split_rows(children, sep="br"):
    """Divide una lista de nodos en filas (separadas por \\) y celdas (por &).

    Devuelve una lista de filas; cada fila es una lista de celdas; cada celda
    es una lista de nodos.
    """
    rows, row, cell = [], [], []
    for nd in children:
        if nd.kind == sep:
            row.append(cell)
            rows.append(row)
            row, cell = [], []
        elif nd.kind == "amp":
            row.append(cell)
            cell = []
        else:
            cell.append(nd)
    row.append(cell)
    rows.append(row)
    # descarta la fila final vacía (la \\ antes de \end)
    if len(rows) > 1 and not _cell_text(rows[-1][0]).strip():
        rows.pop()
    return rows


def _cell_text(nodes):
    return "".join(nd.value for nd in nodes if nd.kind == "text")


SKIP_CMDS = {
    "paliText", "englishText", "renewcommand", "markboth", "clearpage",
    "setTocDelegatedPageNumber", "chapterTocDelegatePageNumber",
    "chapterTocSubIndentTrue", "chapterTocSubIndentFalse",
    "setEnglishTextSize", "label",
}


def emit(nodes, ctx, out):
    """Escribe la traducción Typst de `nodes` en la lista `out`."""
    i = 0
    n = len(nodes)
    while i < n:
        nd = nodes[i]
        k = nd.kind

        if k == "text":
            t = nd.value
            if not t.strip():
                # conserva los saltos de línea en blanco como separadores
                nl = t.count("\n")
                out.append("\n" * min(nl, 2))
                i += 1
                continue
            if ctx.pending:
                out.append("".join(ctx.pending))
                ctx.pending = []
            out.append(esc(t))
            i += 1
            continue

        if k == "br":
            out.append(" #linebreak() ")
            i += 1
            continue

        if k == "amp":
            out.append(" & ")
            i += 1
            continue

        if k == "cmd":
            if nd.value == "chapter":
                # ¿hay un \firstline inmediatamente posterior?
                primera = ""
                salto = 0
                for off, nd2 in enumerate(nodes[i + 1:i + 10], start=1):
                    if nd2.kind == "cmd" and nd2.value == "firstline":
                        primera = _arg(nd2.args)
                        salto = off
                        break
                    if nd2.kind == "cmd" and nd2.value in SKIP_CMDS:
                        continue
                    if nd2.kind == "text" and not nd2.value.strip():
                        continue
                    break
                titulo = _arg(nd.args)
                tipo = "sub" if ctx.sub_indent else "cap"
                ctx.sub_indent = False
                out.append('#capitulo("%s")\n' % esc(titulo).replace('"', '\\"'))
                out.append(
                    '#metadata((tipo: "%s", titulo: "%s")) <toc>\n'
                    % (tipo, esc(titulo).replace('"', '\\"'))
                )
                if primera:
                    ctx.pending.append(
                        '#metadata((tipo: "primera-linea", texto: "%s")) <primera-linea>'
                        % esc(primera).replace('"', '\\"')
                    )
                i += 1 + salto
                continue
            _emit_cmd(nd, ctx, out)
            i += 1
            continue

        if k == "env":
            _emit_env(nd, ctx, out)
            i += 1
            continue

        i += 1


def _emit_cmd(nd, ctx, out):
    name = nd.value
    args = nd.args or []

    # ----maquetación de página-----------------------------------------
    if name == "chapter":
        titulo = _arg(args)
        # busca un \firstline inmediatamente posterior
        primera = ""
        for kind, val in args:
            if kind == "opt" and val.startswith("firstline="):
                primera = val.split("=", 1)[1]
        out.append("#capitulo[%s]" % esc(titulo))
        if primera:
            ctx.pending.append(
                '#metadata((tipo: "primera-linea", texto: "%s")) <primera-linea>'
                % esc(primera).replace('"', '\\"')
            )
        return

    if name == "part":
        ctx.part += 1
        titulo = _arg(args)
        out.append("#parte(%d, [%s])\n" % (ctx.part, esc(titulo)))
        return

    if name == "chapterTocSubIndentTrue":
        ctx.sub_indent = True
        return

    if name == "clearpage" or name == "newpage":
        out.append("#pagebreak()\n")
        return

    if name == "firstline":
        ctx.pending.append(
            '#metadata((tipo: "primera-linea", texto: "%s")) <primera-linea>'
            % esc(_arg(args)).replace('"', '\\"')
        )
        return

    # ----cambio de cuerpo----------------------------------------------
    if name == "paliText":
        out.append("\n#set text(size: 12.5pt)\n#set par(leading: 21pt, spacing: 5pt)\n")
        return

    if name == "englishText":
        out.append("\n#set text(size: 12pt)\n#set par(leading: 17pt, spacing: 8pt)\n")
        return

    # ----rótulos--------------------------------------------------------
    if name == "soloinstr":
        out.append("#soloinstr[%s]" % esc(_arg(args)))
        return

    if name == "instr":
        out.append("#instr[%s]" % esc(_arg(args)))
        return

    if name == "sidepar":
        out.append("#sidepar[%s]" % esc(_arg(args)))
        return

    # ----macros redefined (englishTitle / paliTitle)--------------------
    if name == "renewcommand":
        destino = _arg(args, "req", 0)
        valor = _arg(args, "req", 1)
        if destino.startswith("\\"):
            ctx.macros[destino[1:]] = valor
        return

    if name == "markboth":
        izq = _arg(args, "req", 0)
        der = _arg(args, "req", 1)
        if izq.startswith("\\"):
            izq = ctx.macro(izq[1:]) or ""
        ctx.pending.append(
            '#metadata((tipo: "marca", texto: "%s")) <marca>' % esc(izq).replace('"', '\\"')
        )
        return

    # ----formato en línea----------------------------------------------
    simple = {
        "emph": "#emph[%s]",
        "textit": "#emph[%s]",
        "textbf": "#strong[%s]",
        "tr": "#emph[%s]",
        "prul": "#underline[%s]",
        "textsc": "#smallcaps[%s]",
        "textnormal": "#text[%s]",
        "upshape": "#text[%s]",
    }
    if name in simple:
        out.append(simple[name] % esc(_arg(args)))
        return

    if name == "thaiFont":
        out.append("#thai[%s]" % esc(_arg(args)))
        return

    if name == "hsp":
        out.append("#h(0.5em)")
        return

    if name == "ldots":
        out.append("...")
        return

    if name == "copyright":
        out.append("©")
        return

    if name == "url" or name == "href":
        out.append(esc(_arg(args, "req", 1) if name == "href" else _arg(args)))
        return

    # ----comandos sin efecto en el texto--------------------------------
    if name in ("label", "suttaref", "thispagestyle", "enlargethispage",
                "setTocDelegatedPageNumber", "chapterTocDelegatePageNumber",
                "chapterTocSubIndentTrue", "chapterTocSubIndentFalse",
                "setlength", "addtocontents", "vspace", "hspace",
                "noindent", "centering", "captionsetup", "setcounter",
                "setcounter", "pageref", "ref"):
        return

    if name == "vspace":
        return

    # ----desconocidos: se muestran entre corchetes para poder revisarlos
    txt = _arg(args)
    out.append("[\\%s%s]" % (name, ("{%s}" % txt) if txt else ""))


def _emit_env(nd, ctx, out):
    name = nd.value
    children = nd.children or []

    # un \clearpage dentro de un entorno debe salir del bloque
    if any(c.kind == "cmd" and c.value in ("clearpage", "newpage")
           for c in children):
        _emit_env_partido(nd, ctx, out)
        return

    if name in ("twochants", "solotwochants"):
        rows = _split_rows(children)
        celdas = []
        for row in rows:
            fila = []
            for celda in row:
                buf = []
                emit(celda, ctx, buf)
                fila.append("[%s]" % "".join(buf).strip())
            if len(fila) == 1 and not fila[0].strip("[]"):
                continue
            celdas.append("(%s)" % ", ".join(fila))
        fn = "twochants" if name == "twochants" else "solotwochants"
        out.append("#%s(%s)" % (fn, ", ".join(celdas)))
        return

    if name in ("onechants", "soloonechants"):
        rows = _split_rows(children)
        celdas = []
        for row in rows:
            buf = []
            emit(row[0], ctx, buf)
            txt = "".join(buf).strip()
            if txt:
                celdas.append("[%s]" % txt)
        fn = "onechants" if name == "onechants" else "soloonechants"
        out.append("#%s(%s)" % (fn, ", ".join(celdas)))
        return

    if name == "leader":
        buf = []
        emit(children, ctx, buf)
        out.append("#leader[%s]" % "".join(buf))
        return

    if name == "paritta":
        buf = []
        emit(children, ctx, buf)
        out.append("#paritta[%s]" % "".join(buf))
        return

    if name == "description":
        out.append("#descripcion(")
        _emit_description(children, ctx, out)
        out.append(")")
        return

    if name == "tabular":
        out.append("#tabla[")
        emit(children, ctx, out)
        out.append("]")
        return

    if name == "center" or name == "centering":
        buf = []
        emit(children, ctx, buf)
        out.append("#align(center)[%s]" % "".join(buf))
        return

    if name in ("itemize", "enumerate", "packeditemize"):
        out.append("#lista[")
        _emit_items(children, ctx, out)
        out.append("]")
        return

    # entorno desconocido: se emite su contenido sin más
    emit(children, ctx, out)


def _emit_env_partido(nd, ctx, out):
    """Emite un entorno dividiéndolo en trozos en cada \\clearpage."""
    name = nd.value
    segmentos = []
    actual = []
    for c in nd.children or []:
        if c.kind == "cmd" and c.value in ("clearpage", "newpage"):
            segmentos.append(actual)
            actual = []
            continue
        actual.append(c)
    segmentos.append(actual)

    for k, seg in enumerate(segmentos):
        if k > 0:
            out.append("#pagebreak()\n")
        buf = []
        emit(seg, ctx, buf)
        if name == "paritta":
            out.append("#paritta[%s]" % "".join(buf))
        elif name == "leader":
            out.append("#leader[%s]" % "".join(buf))
        else:
            out.append("".join(buf))


def _emit_description(children, ctx, out):
    """\\begin{description} con \\item[Etiqueta] texto ...

    El texto de cada entrada es el contenido que sigue al \\item hasta el
    siguiente \\item.
    """
    entradas = []
    actual = None
    for nd in children:
        if nd.kind == "cmd" and nd.value == "item":
            etiqueta = _arg(nd.args, "opt", 0)
            actual = [etiqueta, []]
            entradas.append(actual)
            continue
        if actual is not None:
            actual[1].append(nd)
    for etiqueta, cuerpo in entradas:
        buf = []
        emit(cuerpo, ctx, buf)
        texto = "".join(buf).strip()
        out.append('("%s", "%s"),' % (esc(etiqueta), texto.replace('"', '\\"')))


def _emit_items(children, ctx, out):
    for nd in children:
        if nd.kind == "cmd" and nd.value == "item":
            texto = _arg(nd.args, "req", 0)
            out.append('"%s",' % esc(texto))
        elif nd.kind == "text" and nd.value.strip():
            out.append(esc(nd.value.strip()))


# --------------------------------------------------------------------------
# 4. Programa principal
# --------------------------------------------------------------------------

def convert(src):
    src = strip_comments(src)
    nodes = parse(src)
    ctx = Ctx()
    out = []
    emit(nodes, ctx, out)
    txt = "".join(out)
    # colapsa más de dos saltos de línea
    txt = re.sub(r"\n{3,}", "\n\n", txt)
    cabecera = '#import "../template-vol2.typ": *\n\n'
    return cabecera + txt.lstrip("\n")


def main():
    if len(sys.argv) != 3:
        print("Uso: tex2typst.py <entrada.tex> <salida.typ>")
        return 1
    src = Path(sys.argv[1]).read_text(encoding="utf-8")
    dst = Path(sys.argv[2])
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(convert(src), encoding="utf-8")
    print("OK  %s -> %s" % (sys.argv[1], sys.argv[2]))
    return 0


if __name__ == "__main__":
    sys.exit(main())

C = {}

-- The maximum line we'll try to output
C.max_len = 0

-- Environments which don't deserve newlines before/after (everything else does)
C.inline_environments = {
  "bmatrix",
  "bmatrix*",
  "Bmatrix",
  "Bmatrix*",
  "cases",
  "dcases",
  "pmatrix",
  "pmatrix*",
  "Pmatrix",
  "Pmatrix*",
  "matrix",
  "matrix*",
  "vmatrix",
  "vmatrix*",
  "Vmatrix",
  "Vmatrix*",
}

-- Control sequences (apart from begin and end) which should be on their own line
C.own_line_controlseqs = {
  "BEGIN",
  "DO",
  "DeclareMathOperator",
  "ELSE",
  "END",
  "ENDFOR",
  "ENDLOOP",
  "ENDPROC",
  "EXIT",
  "Else",
  "EndFor",
  "EndFunction",
  "EndIf",
  "EndWhile",
  "FI",
  "FOR",
  "For",
  "ForAll",
  "Function",
  "IF",
  "If",
  "LOOP",
  "OD",
  "PROC",
  "REPEAT",
  "UNTIL",
  "While",
  "author",
  "date",
  "documentclass",
  "item",
  "choice", -- Used in the `exam.cls`.
  "CorrectChoice", -- Used in the `exam.cls`.
  -- "label",
  "newcommand",
  "newfloat",
  "newtheorem",
  "renewcommand",
  "setlist",
  "theoremstyle",
  "title",
  "usepackage",
  "usepgfplotslibrary",
  "usetikzlibrary",
}

-- Control sequences which should at least start their own line
C.start_line_controlseqs = {
  "addplot",
  "addplot3",
  "caption",
  "cfoot",
  "chead",
  "clip",
  "coordinate",
  "DeclarePairedDelimiter",
  "DeclarePairedDelimiterX",
  "draw",
  "fill",
  "foreach",
  "node",
  "path",
  "rfoot",
  "rhead",
  "State",
  "tikzstyle",
  "tkzCircumCenter",
  "tkzClipCircle",
  "tkzCompass",
  "tkzDefLine",
  "tkzDefMidPoint",
  "tkzDefPoint",
  "tkzDefPointBy",
  "tkzDefPointWith",
  "tkzDrawArc",
  "tkzDrawCircle",
  "tkzDrawLine",
  "tkzDrawLines",
  "tkzDrawPoints",
  "tkzDrawPolygon",
  "tkzDrawSector",
  "tkzDrawSegment",
  "tkzDrawSegments",
  "tkzFillCircle",
  "tkzFillSector",
  "tkzFindAngle",
  "tkzFindSlopeAngle",
  "tkzGetPoint",
  "tkzGetPoints",
  "tkzInterCC",
  "tkzInterLC",
  "tkzInterLL",
  "tkzLabelAngle",
  "tkzLabelCircle",
  "tkzLabelPoints",
  "tkzLabelSegment",
  "tkzMarkAngle",
  "tkzMarkRightAngle",
  "tkzMarkSegment",
  "tkzMarkSegments",
  "tkzSetUpCompass",
  "tkzSetUpLine",
  "tkzShowLine",
  "tkzVecLen",
  -- my additions
  "multicolumn",
  "hline",
  "part", -- Used in the `exam.cls`.
}

-- Environments in which newlines cannot be added haphazardly
C.tabular_like_environments = {
  "align",
  "align*",
  "alignat",
  "alignat*",
  "aligned",
  "aligned*",
  "eqnarray",
  "eqnarray*",
  "gather",
  "gather*",
  "tabu",
  "tabular",
  "tabular*",
  "tabularx",
  "tabularx*",
  "tabularX",
  "tabularX*",
  "tikzcd",
}

-- Environments which should be treated as verbatim: no formatting at all
C.verbatim_like_environments = {
  "Verbatim",
  "alltt",
  "knot",
  "verbatim",
}

-- Control sequences which should be on their own paragraphs
C.own_paragraphs = {
  "clearpage",
  "documentclass",
  "newpage",
  "chapter",
  "section",
  "subsection",
  "subsubsection",
  "subsubsubsection",
  "vfill",
}

-- Control sequences which should increase indentation
C.indent_incrementers = {
  -- "(",
  -- "BEGIN",
  -- "DO",
  -- "Else",
  -- "FOR",
  -- "ForAll",
  -- "Function",
  -- "IF",
  -- "If",
  -- "LOOP",
  -- "PROC",
  -- "REPEAT",
  -- "Start",
  -- "[",
  -- "item",
}

-- Control sequences which should decrease indentation
C.indent_decrementers = {
  -- ")",
  -- "END",
  -- "ENDFOR",
  -- "ENDLOOP",
  -- "ENDPROC",
  -- "EXIT",
  -- "Else",
  -- "End",
  -- "EndFor",
  -- "EndFunction",
  -- "EndIf",
  -- "FI",
  -- "OD",
  -- "UNTIL",
  -- "]",
  -- "item",
}

return C

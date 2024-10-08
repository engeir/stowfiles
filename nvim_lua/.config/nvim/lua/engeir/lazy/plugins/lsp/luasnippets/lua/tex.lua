local utils = require("luasnip-latex-snippets.util.utils")

-- This is actually not necessary, but lua_ls complains otherwise.
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node

local rec_ls
rec_ls = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, { t({ "", "  \\item " }), i(1), d(2, rec_ls, {}) }),
    })
  )
end
local rec_ls_desc
rec_ls_desc = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(
        nil,
        { t({ "", "  \\item[" }), i(1), t({ "] " }), i(2), d(3, rec_ls_desc, {}) }
      ),
    })
  )
end
return {
  -- Normal
  -- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
  -- \item as necessary by utilizing a choiceNode.
  s({ name = "Itemize", trig = "itemize-lua" }, {
    t({ "\\begin{itemize}", "  \\item " }),
    i(1),
    d(2, rec_ls, {}),
    t({ "", "\\end{itemize}" }),
  }),
  s({ name = "Enumerate", trig = "enumerate-lua" }, {
    t({ "\\begin{enumerate}", "  \\item " }),
    i(1),
    i(2),
    d(2, rec_ls, {}),
    t({ "", "\\end{enumerate}" }),
  }),
  s({ name = "Description", trig = "description-lua" }, {
    t({ "\\begin{description}", "  \\item[" }),
    i(1),
    t({ "] " }),
    i(2),
    d(3, rec_ls_desc, {}),
    t({ "", "\\end{description}" }),
  }),
  s("frame", {
    t({ "\\begin{frame}{" }),
    i(1, "Frame Title"),
    t({ "}", "\t" }),
    i(2),
    t({ "", "\\end{frame}" }),
  }),
  -- Citations, references, glossaries, acronyms, etc.
  s({ name = "Text citation", trig = "citet" }, { t({ "\\citet{" }), i(1), t("}") }),
  s(
    { name = "Parentheses citation", trig = "citep" },
    { t({ "\\citep{" }), i(1), t("}") }
  ),
  s("quote", { t({ "``" }), i(1), t("''") }),
}, {
  -- Auto
  s({ trig = "..." }, { t("\\ldots") }),
  s(
    { trig = "acrs", name = "Short acronym (glossaries)" },
    { t({ "\\acrshort{" }), i(1), t("}") }
  ),
  s(
    { trig = "acrf", name = "Full acronym (glossaries)" },
    { t({ "\\acrfull{" }), i(1), t("}") }
  ),
  s(
    { trig = ".ac", name = "Short acronym (acronym)" },
    { t({ "\\ac{" }), i(1), t("}") }
  ),
  s({ trig = "creff" }, { t("\\cref{"), i(1, "one"), t("}") }),
  s({ trig = "Creff" }, { t("\\Cref{"), i(1, "one"), t("}") }),
  s({ trig = ".cit", name = "Text citation" }, { t({ "\\citet{" }), i(1), t("}") }),
  s(
    { trig = ".fig", name = "Figure reference" },
    { t({ "Fig.~\\ref{fig:" }), i(1), t("}") }
  ),
  s(
    { trig = ".Fig", name = "Figure reference" },
    { t({ "Figure~\\ref{fig:" }), i(1), t("}") }
  ),
  s(
    { trig = ".tab", name = "Table reference" },
    { t({ "table~\\ref{tab:" }), i(1), t("}") }
  ),
  s(
    { trig = ".Tab", name = "Table reference" },
    { t({ "Table~\\ref{tab:" }), i(1), t("}") }
  ),
  s(
    { trig = ".eq", name = "Equation reference" },
    { t({ "Eq.~\\ref{eq:" }), i(1), t("}") }
  ),
  s(
    { trig = ".Eq", name = "Equation reference" },
    { t({ "Equation~\\ref{eq:" }), i(1), t("}") }
  ),
  -- s(
  --     { trig = ".cit", name = "Text citation" },
  --     {
  --         t({ "\\citet" }),
  --         c(2, {
  --             t("["),
  --             i(nil),
  --             t("]"),
  --             t("["),
  --             i(nil),
  --             t("]"),
  --         }),
  --         t("{"),
  --         i(1),
  --         t("}"),
  --     }
  -- ),
  s(
    { trig = ".cip", name = "Parentheses citation" },
    { t({ "\\citep{" }), i(1), t("}") }
  ),
  s({ trig = "mk" }, { t("\\("), i(1), t("\\)") }),
  s(
    { trig = "mrm", wordTrig = false },
    { t("\\mathrm{"), i(1), t("}") },
    { condition = utils.is_math() }
  ),
  s({ trig = ".ce" }, { t({ "\\ce{" }), i(1), t("}") }),
  s(
    { trig = ".gls", name = "Short acronym (acronym)" },
    { t({ "\\gls{" }), i(1), t("}") }
  ),
  s({ trig = ".qt" }, { t({ "``" }), i(1), t("''") }),
  -- s({trig=".fig", name="Figure"}, {
  --         t({"\\begin{figure}"})
  --         "\\begin{figure}${2:[${1:htpb}]}",
  --         "\t\\centering",
  --         "\t${3:\\includegraphics[width=0.95\\linewidth]{figures/$4}}",
  --         "\t\\caption{${5:$4}}%",
  --         "\t\\label{fig:${6:${4/\\W+/-/g}}}",
  --         "\\end{figure}"
  --     }),
}

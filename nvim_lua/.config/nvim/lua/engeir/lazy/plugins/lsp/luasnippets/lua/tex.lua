local ts_utils = require("luasnip-latex-snippets.util.ts_utils")

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
            sn(nil, { t({ "", "  \\item[" }), i(1), t({ "] " }), i(2), d(3, rec_ls_desc, {}) }),
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
    s({ name = "Parentheses citation", trig = "citep" }, { t({ "\\citep{" }), i(1), t("}") }),
    s("quote", { t({ "``" }), i(1), t("''") }),
}, {
    -- Auto
    s({ trig = "..." }, { t("\\ldots") }),
    s({ trig = "acrs", name = "Short acronym" }, { t({ "\\acrshort{" }), i(1), t("}") }),
    s({ trig = "acrf", name = "Full acronym" }, { t({ "\\acrfull{" }), i(1), t("}") }),
    s({ trig = "creff" }, { t("\\cref{fig:"), i(1, "one"), t("}") }),
    s({ trig = "Creff" }, { t("\\Cref{fig:"), i(1, "one"), t("}") }),
    s({ trig = ".cit", name = "Text citation" }, { t({ "\\citet{" }), i(1), t("}") }),
    s({ trig = ".cip", name = "Parentheses citation" }, { t({ "\\citep{" }), i(1), t("}") }),
    s({ trig = "mk" }, { t("\\("), i(1), t("\\)") }),
    s({ trig = "mrm" }, { t("\\mathrm{"), i(1), t("}") }, { condition = ts_utils.in_mathzone }),
    s({ trig = ".ce" }, { t({ "\\ce{" }), i(1), t("}") }),
    s({ trig = ".qt" }, { t({ "``" }), i(1), t("''") }),
    s({ trig = "sub", wordTrig = false }, { t("_{"), i(1), t("}"), i(0) }, { condition = ts_utils.in_mathzone }),
    s({ trig = "sup", wordTrig = false }, { t("^{"), i(1), t("}"), i(0) }, { condition = ts_utils.in_mathzone }),
    s({
        trig = "_(%w%w)",
        name = "auto subscript 3",
        regTrig = true,
        wordTrig = false,
        -- snippetType = "autosnippet",
    }, {
        f(function(_, snip)
            return string.format("_{%s", snip.captures[1])
        end, {}),
        i(1),
        t("}"),
        i(0),
    }, { condition = ts_utils.in_mathzone }),
    s({
        trig = ",(%w%w)",
        name = "auto superscript",
        regTrig = true,
        wordTrig = false,
        -- snippetType = "autosnippet",
    }, {
        f(function(_, snip)
            return string.format("^{%s", snip.captures[1])
        end, {}),
        i(1),
        t("}"),
        i(0),
    }, { condition = ts_utils.in_mathzone }),
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

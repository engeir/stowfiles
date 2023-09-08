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
    s("ce", { t({ "\\ce{" }), i(1), t("}") }),
    s("quote", { t({ "``" }), i(1), t("''") }),
}, {
    -- Auto
    s({ name = "Short acronym", trig = "acrs" }, { t({ "\\acrshort{" }), i(1), t("}") }),
    s({ trig = "acrf" }, { t({ "\\acrfull{" }), i(1), t("}") }),
    s({ trig = "creff" }, { t("\\cref{fig:"), i(1, "one"), t("}") }),
    s({ trig = "Creff" }, { t("\\Cref{fig:"), i(1, "one"), t("}") }),
    -- Replaced by iurimateus/luasnip-latex-snippets.nvim
    s({ trig = "mk" }, { t("\\("), i(1), t("\\)") }),
}

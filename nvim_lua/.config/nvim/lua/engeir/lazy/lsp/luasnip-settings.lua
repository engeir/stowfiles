-- Configuration
local ok, ls = pcall(require, "luasnip")
if not ok then
    return
end
local ok2, types = pcall(require, "luasnip.util.types")
if not ok2 then
    return
end

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    },
})

-- See https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
-- and teeeej's taketuesday #3 videos for more sweetness
-- Define keymaps
-- Expansion and jump forward key <c-k>
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })
-- Jump backward <c-j> (default is just to create a newline)
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
-- <c-l> is for selecting within a list of options.
-- Useful for choice nodes (introduced in the second luasnip tutorial by teeeej)
vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)
-- Source this file
vim.keymap.set(
    "n",
    "<leader><leader>s",
    "<cmd>source ~/.config/nvim/lua/engeir/lazy/lsp/luasnip-settings.lua<CR>",
    { desc = "LuaSnip: Source Snippets File" }
)

-- Define useful local variables to generate snippets
--This is a snippet creator
-- s(<trigger>, <nodes>)
local s = ls.s
local sn = ls.snippet_node

-- This is a format node.
-- It takes a format string, and a list of nodes
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- This is an insert node
-- It takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node

-- Repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node

-- Load in some snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/engeir/lazy/lsp/luasnippets" } })
-- Create some snippets
ls.add_snippets("all", {
    ls.parser.parse_snippet("expandme", "-- hello there"),
    ls.parser.parse_snipmate("weeknum", "`strftime('%U')`"),
})

-- Lua =================================================================================
ls.add_snippets("lua", {
    -- Lua specific snippets go here.
    s(
        "re",
        fmt(
            'local {}, {} = pcall(require, "{}")\nif not {} then\n  return\nend',
            { i(1, "default"), i(2), rep(2), rep(1) }
        )
    ),
})

-- Python ==============================================================================
ls.add_snippets("python", {
    s({ trig = "iplt", snippetType = "autosnippet" }, {
        t("import matplotlib.pyplot as plt"),
    }),
})

-- Markdown ============================================================================
ls.add_snippets("markdown", {
    s({ trig = "frr", snippetType = "autosnippet" }, {
        t("\\frac{"),
        i(1),
        t("}{"),
        i(2),
        t("}"),
    }),
    s({ trig = "phi-raw" }, { t("𝜙") }),
    s({ trig = "Phi-raw" }, { t("𝛷") }),
    s({ trig = "theta-raw" }, { t("𝜃") }),
    s({ trig = "Theta-raw" }, { t("𝛩") }),
    s({ trig = "alpha-raw" }, { t("𝛼") }),
    s({ trig = "Alpha-raw" }, { t("𝛢") }),
})

-- Tex =================================================================================
-- 'recursive' dynamic snippet. Expands to some text followed by itself.
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
ls.add_snippets("tex", {
    -- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
    -- \item as necessary by utilizing a choiceNode.
    s("itemize-lua", {
        t({ "\\begin{itemize}", "  \\item " }),
        i(1),
        d(2, rec_ls, {}),
        t({ "", "\\end{itemize}" }),
    }),
    s("enumerate-lua", {
        t({ "\\begin{enumerate}", "  \\item " }),
        i(1),
        i(2),
        d(2, rec_ls, {}),
        t({ "", "\\end{enumerate}" }),
    }),
    s("description-lua", {
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
    s("mathin", { t("\\("), i(1), t("\\)") }),
    s("citet", { t({ "\\citet{" }), i(1), t("}") }),
    s("citep", { t({ "\\citep{" }), i(1), t("}") }),
    s("ce", { t({ "\\ce{" }), i(1), t("}") }),
}, {
    key = "tex",
})

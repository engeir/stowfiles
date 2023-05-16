return {
    "lervag/vimtex",
    enabled = IS_KNOWN,
    init = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_mode = 2
        -- vim.g.vimtex_compiler_method = '' -- xelatex and lualatex are not supported by default
    end,
    config = function()
        -- vim.keymap.set("n", "<localleader><localleader>t", ":VimtexTocOpen<CR>", { remap = false, silent = true })
        vim.keymap.set("n", "<localleader>t", ":VimtexTocToggle<CR>", { desc = "Vimtex: Open [T]oC (Toggle)" })
        vim.keymap.set("n", "<localleader>cw", ":VimtexCountWords<CR>", { desc = "Vimtex: [C]ount [W]ords" })
        vim.keymap.set("n", "<localleader>cl", ":VimtexCountLetters<CR>", { desc = "Vimtex: [C]ount [L]etters" })
    end,
}

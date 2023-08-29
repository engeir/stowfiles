return {
    "lervag/vimtex",
    enabled = IS_KNOWN,
    init = function()
        vim.g.tex_flavor = "latex"
        if IS_MAC then
            vim.g.vimtex_view_method = "sioyek"
        else
            vim.g.vimtex_view_method = "zathura"
        end
        vim.g.vimtex_quickfix_mode = 2
        -- latexmk is the default option and seems to be the only one supporting
        -- continuous mode
        -- vim.g.vimtex_compiler_method = "tectonic" -- latexmk, latexrun, tectonic, arara, generic
    end,
    config = function()
        -- vim.keymap.set("n", "<localleader><localleader>t", ":VimtexTocOpen<CR>", { remap = false, silent = true })
        vim.keymap.set("n", "<localleader>t", ":VimtexTocToggle<CR>", { desc = "Vimtex: Open [T]oC (Toggle)" })
        vim.keymap.set("n", "<localleader>cw", ":VimtexCountWords<CR>", { desc = "Vimtex: [C]ount [W]ords" })
        vim.keymap.set("n", "<localleader>cl", ":VimtexCountLetters<CR>", { desc = "Vimtex: [C]ount [L]etters" })
    end,
}

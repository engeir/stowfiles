return {
    "lervag/vimtex",
    enabled = IS_KNOWN,
    init = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_mode = 0
        -- vim.g.vimtex_compiler_method = '' -- xelatex and lualatex are not supported by default
    end,
    config = function()
        vim.keymap.set("n", "<localleader><localleader>t", ":VimtexTocOpen<CR>", { remap = false, silent = true })
        vim.keymap.set("n", "<localleader><localleader>T", ":VimtexTocToggle<CR>", { remap = false, silent = true })
    end,
}

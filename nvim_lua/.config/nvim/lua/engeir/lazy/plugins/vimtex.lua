return {
  "lervag/vimtex",
  event = { "BufReadPre", "BufNewFile" },
  enabled = IS_KNOWN,
  init = function()
    vim.g.tex_flavor = "latex"
    if IS_MAC then
      vim.g.vimtex_view_method = "sioyek"
    else
      vim.g.vimtex_view_method = "zathura"
    end
    vim.g.vimtex_quickfix_mode = 2
    vim.g.vimtex_log_ignore = {
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
    }
    -- latexmk is the default option and seems to be the only one supporting
    -- continuous mode
    -- vim.g.vimtex_compiler_method = "mise exec -- latexmk" -- latexmk, latexrun, tectonic, arara, generic
  end,
  config = function()
    -- vim.keymap.set("n", "<localleader><localleader>t", ":VimtexTocOpen<CR>", { remap = false, silent = true })
    vim.keymap.set(
      "n",
      "<localleader>t",
      ":VimtexTocToggle<CR>",
      { desc = "Vimtex: Open [T]oC (Toggle)" }
    )
    vim.keymap.set(
      "n",
      "<localleader>cw",
      ":VimtexCountWords<CR>",
      { desc = "Vimtex: [C]ount [W]ords" }
    )
    vim.keymap.set(
      "n",
      "<localleader>cl",
      ":VimtexCountLetters<CR>",
      { desc = "Vimtex: [C]ount [L]etters" }
    )
    vim.keymap.set(
      "n",
      "<localleader>lb",
      -- "<cmd>!bibexport -o %:p:r.bib %:p:r.aux<CR>",
      "<cmd>!bibfish -f % ~/science/ref/ref.bib %:p:r.bib<CR><CR>",
      { desc = "Vimtex: [B]ibexport" }
    )
  end,
}

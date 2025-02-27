return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.tex_flavor = "latex"
    if vim.fn.has("macunix") == 1 then
      vim.g.vimtex_view_method = "sioyek"
    else
      vim.g.vimtex_view_method = "zathura"
    end
    vim.g.vimtex_complete_close_braces = 1
    vim.g.vimtex_quickfix_mode = 2
    vim.g.vimtex_log_ignore = {
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
    }
  end,
  config = function()
    vim.keymap.set(
      "n",
      "<localleader>lt",
      ":VimtexTocToggle<CR>",
      { desc = "Toggle ToC (Vimtex)" }
    )
    vim.keymap.set(
      "n",
      "<localleader>lw",
      "<cmd>VimtexCountWords<CR>",
      { desc = "Count Words (Vimtex)" }
    )
    vim.keymap.set(
      "n",
      "<localleader>lh",
      "<cmd>VimtexCountLetters<CR>",
      { desc = "Count Characters (Vimtex)" }
    )
    vim.keymap.set(
      "n",
      "<localleader>lb",
      "<cmd>!bibfish -c 'cite,citet,citep,citeA' -f % ~/science/ref/ref.bib %:p:r.bib<CR><CR>",
      { desc = "Bibfish export (Vimtex)" }
    )
  end,
}

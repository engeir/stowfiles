local opts = { silent = true, noremap = true }
-- General terminal mappings
function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<M-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<M-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<M-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<M-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local keymap = vim.keymap.set
return {
  {
    "voldikss/vim-floaterm",
    init = function()
      vim.g.floaterm_width = 0.45
    end,
    keys = {
      {
        "<leader>to",
        ":FloatermNew --wintype=vsplit --autohide=0 python<CR><C-\\><C-n><C-w>h",
        desc = "[T]erm [O]pen (Python)",
      },
      {
        "<leader>pv",
        ":FloatermNew --wintype=float --position=right --autoclose=2 nnn -dH<CR>",
        silent = true,
        noremap = true,
        desc = "Open Floaterm [P]ath [V]iewer",
      },
      {
        "<leader>H",
        ":/%%<CR>VN",
        desc = "Notebook: Jump to next [H]ighligh region",
        silent = true,
        noremap = true,
      },
      {
        "<C-r>",
        ":'<,'>FloatermSend <CR>",
        desc = "Run visual select in Floaterm",
        noremap = true,
        silent = true,
      },
      {
        "<leader>tr",
        ":FloatermNew --wintype=float --position=right --autoclose=0 compiler %<CR>",
        desc = "[R]un compiler on script",
      },
      {
        "<leader>tn",
        ":FloatermNext <CR>",
        silent = true,
        noremap = true,
        desc = "[T]erm [N]ext",
      },
      {
        "<leader>tp",
        ":FloatermPrev <CR>",
        silent = true,
        noremap = true,
        desc = "[T]erm [P]revious",
      },
      {
        "<leader>th",
        ":FloatermHide <CR>",
        silent = true,
        noremap = true,
        desc = "[T]erm [H]ide",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    enabled = false,
    events = { "BufReadPre" },
    version = "*",
    opts = { shade_terminals = true },
    config = function()
      keymap("n", "<leader>ft", ":ToggleTerm direction=float<CR>", opts)
      keymap(
        "n",
        "<leader>to",
        ":TermExec size=100 direction=vertical cmd='python'<CR>",
        opts
      )
      keymap(
        "n",
        "<leader>pv",
        ":TermExec close_on_exit=true border=curved direction=float size=90 cmd='nnn -dH'<CR>",
        opts
      )
      keymap("n", "<leader>H", ":/%%<CR>VN", opts)
      keymap("v", "<C-r>", ":'<,'>ToggleTermSendVisualLines <CR>", opts)
      keymap(
        "n",
        "<leader>tr",
        ":TermExec direction=float go_back=0 cmd='compiler %'<CR>",
        opts
      )
    end,
  },
}

local opts = { silent = true, noremap = true }
-- General terminal mappings
function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local keymap = vim.keymap.set
return {
  {
    "voldikss/vim-floaterm",
    events = { "BufReadPre" },
    init = function()
      vim.g.floaterm_width = 0.45
    end,
    config = function()
      -- keymap("n", "<leader>ft", "<cmd>FloatermToggle<CR>", opts)
      keymap(
        "n",
        "<leader>to",
        ":FloatermNew --wintype=vsplit --autohide=0 python<CR><C-\\><C-n><C-w>h",
        { desc = "[T]erm [O]pen (Python)" }
      )
      keymap(
        "n",
        "<leader>pv",
        ":FloatermNew --wintype=float --position=right --autoclose=2 nnn -dH<CR>",
        opts
      )
      keymap("n", "<leader>H", ":/%%<CR>VN", opts)
      keymap(
        "v",
        "<C-r>",
        ":'<,'>FloatermSend <CR>",
        { desc = "Run visual select in Floaterm", noremap = true, silent = true }
      )
      keymap(
        "n",
        "<leader>tr",
        ":FloatermNew --wintype=float --position=right --autoclose=0 compiler %<CR>",
        { desc = "[R]un compiler on script" }
      )
      keymap("n", "<leader>tn", ":FloatermNext <CR>", opts)
      keymap("n", "<leader>tp", ":FloatermPrev <CR>", opts)
      keymap("n", "<leader>th", ":FloatermHide <CR>", opts)
    end,
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
  {
    "siadat/shell.nvim",
    events = { "BufReadPre" },
    opts = {},
  },
}

-- Set up python provider
-- Create a venv and install pynvim, i.e.
-- python -m pip install --user --upgrade pynvim
-- Finally we set it as the python3_host_prog:
-- Probably need to use uname -o
local os = vim.fn.systemlist("uname -s")
local os2 = vim.fn.systemlist("uname -n")
if os[1] == "Linux" then
    if os2[1] == "ubuntu-work" then
        vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/py3nvim/bin/python")
        vim.cmd("source $HOME/.config/cdo/add_cdo_complete_to_your_vimrc")
    elseif string.find(os2[1], "fram.sigma2.no") then
        vim.g.python3_host_prog = vim.fn.expand("$HOME/Envs/py3nvim/bin/python")
        vim.cmd("source $HOME/.config/cdo/add_cdo_complete_to_your_vimrc")
    end
elseif os[1] == "Darwin" then
    vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/py3nvim/bin/python")
end

-- General stuff
require("engeir.settings")
require("engeir.keymaps")
require("engeir.plugins")

-- Extra stuff
-- require("engeir.neorg")
-- require("engeir.org-mode")
-- require("engeir.refactoring")
require("engeir.aerial")
require("engeir.align")
require("engeir.alpha")
require("engeir.autocommands")
require("engeir.bufferline")
require("engeir.cmp")
require("engeir.cmp_gh_source")
require("engeir.color-picker")
require("engeir.colorschemes")
require("engeir.comment-nvim")
require("engeir.copilot")
require("engeir.customcommands")
require("engeir.dial-nvim")
require("engeir.diffview")
require("engeir.easypick")
require("engeir.gitsigns")
require("engeir.glow")
require("engeir.grammar-guard")
require("engeir.harpoon")
require("engeir.image-nvim")
require("engeir.lsp")
require("engeir.lualine")
require("engeir.luasnip")
require("engeir.magma")
require("engeir.neodim")
require("engeir.neogit")
require("engeir.nvim-tree")
require("engeir.smartyank")
require("engeir.syntax-tree-surfer")
require("engeir.telescope")
require("engeir.terminal")
require("engeir.todo-comments-nvim")
require("engeir.treesitter")
require("engeir.treesitter-context")
require("engeir.vim-angry-reviewer")
require("engeir.vim-rooter")

-- Set up python provider
-- Create a venv and install pynvim, i.e.
-- python -m pip install --user --upgrade pynvim
-- Finally we set it as the python3_host_prog:
-- Probably need to use uname -o
local OS = vim.fn.systemlist("uname -s")
local OS2 = vim.fn.systemlist("uname -n")
if OS[1] == "Linux" then
    if OS2[1] == "ubuntu-work" then
        vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/py3nvim/bin/python")
        vim.cmd("source $HOME/.config/cdo/add_cdo_complete_to_your_vimrc")
    elseif string.find(OS2[1], "fram.sigma2.no") then
        vim.g.python3_host_prog = vim.fn.expand("$HOME/Envs/py3nvim/bin/python")
        vim.cmd("source $HOME/.config/cdo/add_cdo_complete_to_your_vimrc")
    end
elseif OS[1] == "Darwin" then
    vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/py3nvim/bin/python")
end

local has = function(x)
    return vim.fn.has(x) == 1
end
local is_wsl = (function()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end)()
local is_mac = has("macunix")
local is_linux = not is_wsl and not is_mac

-- General stuff
require("engeir.settings")
require("engeir.keymaps")
require("engeir.plugins")

-- Extra stuff
require("engeir.align")
require("engeir.alpha")
require("engeir.autocommands")
require("engeir.cmp")
require("engeir.colorschemes")
require("engeir.comment-nvim")
require("engeir.copilot")
require("engeir.dial-nvim")
require("engeir.diffview")
require("engeir.gitsigns")
require("engeir.glow")
require("engeir.grammar-guard")
require("engeir.harpoon")
require("engeir.lsp")
require("engeir.lualine")
require("engeir.neodim")
require("engeir.neogit")
require("engeir.nvim-tree")
require("engeir.refactoring")
require("engeir.telescope")
require("engeir.terminal")
require("engeir.todo-comments-nvim")
require("engeir.treesitter")
require("engeir.treesitter-context")
require("engeir.vim-angry-reviewer")
require("engeir.vim-rooter")

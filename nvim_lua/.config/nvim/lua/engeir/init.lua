local has = function(x)
  return vim.fn.has(x) == 1
end
local is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()
local is_mac = has "macunix"
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
require("engeir.refactoring")
require("engeir.telescope")
require("engeir.terminal")
require("engeir.todo-comments-nvim")
require("engeir.treesitter")
require("engeir.vim-angry-reviewer")

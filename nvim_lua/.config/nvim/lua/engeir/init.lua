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
require("engeir.autocommands")
require("engeir.cmp")
require("engeir.colorschemes")
require("engeir.gitsigns")
require("engeir.lsp")
require("engeir.toggleterm")
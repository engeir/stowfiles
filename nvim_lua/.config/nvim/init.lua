vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
require("engeir.basics.globals")

-- General stuff
require("engeir.basics.keymaps")
require("engeir.basics.settings")
require("engeir.basics.python-settings")

-- Plugins
require("engeir.lazy")

-- Commands potentially relying on plugins
require("engeir.basics.autocommands")
require("engeir.basics.customcommands")
-- vim: ts=2 sts=2 sw=2 et

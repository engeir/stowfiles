vim.loader.enable() -- From the impatient.nvim repo
require("engeir.basics.globals")

-- General stuff
require("engeir.basics.autocommands")
require("engeir.basics.customcommands")
require("engeir.basics.keymaps")
require("engeir.basics.settings")
require("engeir.basics.python-settings")

-- Plugins
require("engeir.lazy")

-- vim: ts=2 sts=2 sw=2 et

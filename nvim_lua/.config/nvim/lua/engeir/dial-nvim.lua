-- I don't think this works at all...

local ok, dial = pcall(require, "dial.map")
if not ok then
    return
end
local ok2, augend = pcall(require, "dial.augend")
if not ok2 then
    return
end

require("dial.config").augends:register_group({
    default = {
        augend.constant.alias.en_weekday,
    },
})

local keymap = vim.keymap.set

keymap("n", "<C-a>", dial.inc_normal(), { noremap = true })
keymap("n", "<C-x>", dial.dec_normal(), { noremap = true })
keymap("v", "<C-a>", dial.inc_visual(), { noremap = true })
keymap("v", "<C-x>", dial.dec_visual(), { noremap = true })
keymap("v", "g<C-a>", dial.inc_gvisual(), { noremap = true })
keymap("v", "g<C-x>", dial.dec_gvisual(), { noremap = true })

-- 2022-12-31

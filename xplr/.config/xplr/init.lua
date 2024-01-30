-- Setup
local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))
-- local home = os.getenv("HOME")
-- package.path = home
--     .. "/.config/xplr/plugins/?/init.lua;"
--     .. home
--     .. "/.config/xplr/plugins/?.lua;"
--     .. home
--     .. "/.local/share/xplr/plugins/?/init.lua;"
--     .. package.path

-- I'm getting an error saying that the version should be global... so here we go
local handle = io.popen("xplr --version")
if handle == nil then
    return 0
end
local result = handle:read("*a")
local secondPart = string.match(result, "%S+%s+(%S+)")
handle:close()
version = secondPart

-- Plugins
require("xpm").setup({
    plugins = {
        -- Let xpm manage itself
        "dtomvan/xpm.xplr",
        { name = "sayanarijit/fzf.xplr" },
        { name = "sayanarijit/material-landscape2.xplr" },
        "sayanarijit/fzf.xplr",
    },
    auto_install = true,
    auto_cleanup = true,
})

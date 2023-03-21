local ok, ai, align, bracketed, comment, cursorword, indentscope, jump, pairs, splitjoin, starter, surround, trailspace =
pcall(
    function()
        return require("mini.ai"),
            require("mini.align"),
            require("mini.bracketed"),
            require("mini.comment"),
            require("mini.cursorword"),
            require("mini.indentscope"),
            require("mini.jump"),
            require("mini.pairs"),
            require("mini.splitjoin"),
            require("mini.starter"),
            require("mini.surround"),
            require("mini.trailspace")
    end
)
if not ok then
    return
end

-- mini.ai -----------------------------------------------------------------------------
ai.setup()

-- mini.align --------------------------------------------------------------------------
align.setup()

-- mini.base16 -------------------------------------------------------------------------
-- require("mini.base16").setup({
--     palette = {
--         base00 = "#fbf1c7",
--         -- Colorcolumn
--         base01 = "#333333",
--         base02 = "#98971a",
--         base03 = "#d79921",
--         base04 = "#458588",
--         base05 = "#b16286",
--         base06 = "#689d6a",
--         base07 = "#7c6f64",
--         base08 = "#928374",
--         base09 = "#9d0006",
--         base0A = "#79740e",
--         base0B = "#b57614",
--         base0C = "#076678",
--         -- Functions
--         base0D = "#e96962",
--         base0E = "#427b58",
--         base0F = "#3c3836",
--     },
--     use_cterm = true,
--     plugins = {
--         default = true,
--         -- ['echasnovski/mini.nvim'] = true,
--     },
-- })

-- mini.bracketed ----------------------------------------------------------------------
bracketed.setup()

-- mini.comment ------------------------------------------------------------------------
comment.setup()
--- Set the comment rule for a file type
---@param pattern string
---@param c_string string
local function set_comment(pattern, c_string)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = pattern,
        callback = function()
            vim.opt_local.commentstring = c_string
        end,
    })
end

set_comment("ncl", ";%s")
set_comment("sent", "#%s")

-- mini.cursorword ---------------------------------------------------------------------
cursorword.setup()

-- mini.pairs --------------------------------------------------------------------------
pairs.setup()

-- mini.indentscope --------------------------------------------------------------------
indentscope.setup()

-- mini.jump ---------------------------------------------------------------------------
jump.setup({ delay = { highlight = 10 ^ 7 } })

-- mini.splitjoin ----------------------------------------------------------------------
splitjoin.setup()

-- mini.surround -----------------------------------------------------------------------
surround.setup()

-- mini.starter ------------------------------------------------------------------------
local function footer()
    -- NOTE: requires the fortune-mod package to work
    -- local handle = io.popen("fortune")
    -- local fortune = handle:read("*a")
    -- handle:close()
    -- return fortune
    local handle = io.popen("nvim --version")
    if handle == nil then
        return "Nvim Config by @engeir"
    end
    local result = "Config by @engeir — " .. string.match(handle:read("*a"), "NVIM v[^\n]*")
    handle:close()
    return result
end

local my_telescope = {
    {
        name = "All files",
        action = "lua require('telescope.builtin').find_files({hidden=true})",
        section = "Telescope",
    },
    { name = "Git files",       action = "lua require'engeir.telescope-extra'.project_files()", section = "Telescope" },
    { name = "Old files",       action = "Telescope oldfiles",                                  section = "Telescope" },
    { name = "Live grep",       action = "Telescope live_grep",                                 section = "Telescope" },
    { name = "Command history", action = "Telescope command_history",                           section = "Telescope" },
    { name = "Help tags",       action = "Telescope help_tags",                                 section = "Telescope" },
}
local items = {
    my_telescope,
    starter.sections.recent_files(5, true, true),
    starter.sections.recent_files(5, false, true),
    { name = "Open TODO", action = ":e ~/Documents/notes_papers/_includes/todo.md", section = "Builtin actions" },
    starter.sections.builtin_actions(),
}
local content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.indexing("all", { "Builtin actions", "Telescope" }),
    starter.gen_hook.aligning("center", "center"),
}
local starter_opts = {
    items = items,
    content_hooks = content_hooks,
    header = [[
                  ██╗
                ██╔═██╗
      ██████╗   ██║ ██║ ██╗
      ╚═════╝   ╚═██╔═╝ ██║
    ██████╗   ██████████╔═╝
    ╚═════╝   ██╔═██╔═══╝
    ██████╗   ██║ ██║
    ╚═════╝   ╚═╝ ██║
    ██████╗ ████╗ ██████╗
    ╚═════╝ ╚═██║ ██║ ██║
      ██████╗ ██████║ ██║
      ╚═════╝ ╚═════╝ ████╗
                      ╚═══╝
]],
    footer = footer(),
}
starter.setup(starter_opts)

-- mini.trailspace ---------------------------------------------------------------------
trailspace.setup()

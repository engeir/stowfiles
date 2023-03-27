local function getWords()
    return tostring(vim.fn.wordcount().words) .. " words"
end
local function getLines()
    return tostring(vim.api.nvim_buf_line_count(0)) .. " lines"
end
local function getFileInfo()
    return getWords() .. ", " .. getLines()
end

return {
    -- Style and colour schemes ===================================================== --
    {
        -- TODO: replace with mini.tabline?
        "akinsho/bufferline.nvim",
        name = "bufferline",
        version = "v2.*",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("bufferline").setup()
            vim.keymap.set("n", "H", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "L", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
        end,
    },
    {
        -- TODO: replace with mini.statusline?
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        opts = {
            options = {
                icons_enabled = true,
                globalstatus = true,
                component_separators = { "", "" },
                theme = "gruvbox",
                -- theme = "auto",
            },
            sections = {
                lualine_c = {
                    function()
                        return "%="
                    end,
                    {
                        "filename",
                        path = 3,
                    },
                    { getFileInfo },
                },
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = {
                "toggleterm",
            },
        },
    },
    -- nvim-ts-rainbow is archived, but nvim-ts-rainbow2 is ugly
    "p00f/nvim-ts-rainbow", -- Different colour for nested parenthesis
    -- "HiPhish/nvim-ts-rainbow2", -- Different colour for nested parenthesis
    {
        "NvChad/nvim-colorizer.lua",
        name = "colorizer",
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                user_default_options = {
                    RGB = true,          -- #RGB hex codes
                    RRGGBB = true,       -- #RRGGBB hex codes
                    names = false,       -- "Name" codes like Blue or blue
                    RRGGBBAA = true,     -- #RRGGBBAA hex codes
                    AARRGGBB = true,     -- 0xAARRGGBB hex codes
                    rgb_fn = true,       -- CSS rgb() and rgba() functions
                    hsl_fn = true,       -- CSS hsl() and hsla() functions
                    css = true,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = "background", -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = false,                               -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
                    virtualtext = "■",
                    -- update color values even if buffer is not focused
                    -- example use: cmp_menu, cmp_docs
                    always_update = false,
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {},
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        opts = {
            keywords = {
                FIXME = {
                    icon = " ",
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            },
        },
    },
    "mechatroner/rainbow_csv",
}

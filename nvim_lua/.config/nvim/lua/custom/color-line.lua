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
            extensions = {
                "toggleterm",
            },
        },
    },
    { "sainnhe/gruvbox-material", lazy = false,       priority = 1000 },
    { "catppuccin/nvim",          name = "catppuccin" },
    "tjdevries/colorbuddy.vim",
    "tjdevries/gruvbuddy.nvim",
    "marko-cerovac/material.nvim",
    -- nvim-ts-rainbow is archived, but nvim-ts-rainbow2 is ugly
    "p00f/nvim-ts-rainbow", -- Different colour for nested parenthesis
    -- "HiPhish/nvim-ts-rainbow2", -- Different colour for nested parenthesis
    {
        "norcalli/nvim-colorizer.lua",
        name = "colorizer",
        config = function()
            require("colorizer").setup()
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

local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

local function getWords()
    return tostring(vim.fn.wordcount().words) .. " words"
end
local function getLines()
    return tostring(vim.api.nvim_buf_line_count(0)) .. " lines"
end
local function getFileInfo()
    return getWords() .. ", " .. getLines()
end

lualine.setup({
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
})

local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

local function getWords()
    return tostring(vim.fn.wordcount().words) .. " words"
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
            { getWords },
        },
    },
    extensions = {
        "toggleterm",
    },
})

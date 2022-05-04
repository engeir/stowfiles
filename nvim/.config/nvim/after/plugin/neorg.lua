local ok, neorg = pcall(require, "neorg")
if not ok then
    return
end

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {
            config = { -- Note that this table is optional and doesn't need to be provided
                -- Configuration here
            },
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.integrations.treesitter"] = {
            config = { -- Note that this table is optional and doesn't need to be provided
                -- Configuration here
            },
        },
    },
})

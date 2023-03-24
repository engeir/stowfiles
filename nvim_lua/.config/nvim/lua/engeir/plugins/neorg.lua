return {
    "nvim-neorg/neorg",
    enabled = false,
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        todo = "~/projects/todo",
                    },
                },
            },
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
            ["core.gtd.base"] = {
                config = { -- Note that this table is optional and doesn't need to be provided
                    workspace = "~/projects/todo",
                },
            },
        },
    },
}

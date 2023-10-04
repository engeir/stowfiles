local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
return {
    Lua = {
        diagnostics = {
            globals = { "vim" },
            -- neededFileStatus = {
            --     ["codestyle-check"] = "Any"
            -- },
        },
        format = {
            enable = true,
            -- Put format options here
            -- NOTE: the value should be String!
            defaultConfig = {
                indent_style = "space",
                indent_size = "4",
            },
        },
        runtime = {
            version = "LuaJIT",
            path = runtime_path,
        },
        telemetry = {
            enable = false,
        },
        workspace = {
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
            },
        },
    },
}

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        disable = { "missing-fields" },
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
          indent_size = "2",
          max_line_length = 88,
        },
      },
      hint = { enable = true },
      runtime = {
        version = "LuaJIT",
        -- path = runtime_path,
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
        -- Tells lua_ls where to find all the Lua files that you have loaded
        -- for your neovim configuration.
        library = {
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
        -- If lua_ls is really slow on your computer, you can try this instead:
        -- library = { vim.env.VIMRUNTIME },
      },
    },
  },
}

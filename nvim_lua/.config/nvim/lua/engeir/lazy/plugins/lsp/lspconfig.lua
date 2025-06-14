return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    -- NOTE: this must be here, so that Mason config is run before this
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "b0o/schemastore.nvim",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(mode, keys, func, desc)
          if desc then desc = "LSP: " .. desc end
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end
        local nmap = function(keys, func, desc) map("n", keys, func, desc) end
        local imap = function(keys, func, desc) map("i", keys, func, desc) end
        local xmap = function(keys, func, desc) map("x", keys, func, desc) end

        vim.keymap.set(
          "n",
          "<leader>wh",
          function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
          { silent = true, noremap = true, desc = "LSP: Toggle virtual text" }
        )
        nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
        nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
        nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
        nmap(
          "gI",
          require("telescope.builtin").lsp_implementations,
          "Goto Implementation"
        )
        nmap(
          "gh",
          require("telescope.builtin").lsp_type_definitions,
          "Goto Type Definition (Hint)"
        )
        nmap(
          "gH",
          function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end,
          "Toggle inlay Hint"
        )
        nmap(
          "<leader>ds",
          require("telescope.builtin").lsp_document_symbols,
          "Document Symbols"
        )
        nmap(
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "Workspace Symbols"
        )
        nmap("<leader>re", "<cmd>LspRestart<cr>", "Lsp [Re]estart")
        nmap("crn", vim.lsp.buf.rename, "Code Refactor rename") -- Default since nvim0.10.0
        nmap("crr", vim.lsp.buf.code_action, "Code Refacotr Refactor (code action)") -- Default since nvim0.10.0
        -- xmap("<leader>ca", vim.lsp.buf.range_code_action, "Range Code Action")
        xmap(
          "<leader>ca",
          "<cmd>lua vim.lsp.buf.range_code_action()<cr>",
          "Range Code Action"
        )
        imap("<C-s>", vim.lsp.buf.signature_help, "Signature Documentation") -- Default since nvim0.10.0
        imap("<C-s>", vim.lsp.buf.signature_help, "Signature Documentation") -- Default since nvim0.10.0
        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
        nmap(
          "<leader>wr",
          vim.lsp.buf.remove_workspace_folder,
          "Workspace Remove Folder"
        )
        nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbol")
        nmap(
          "<leader>wl",
          function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
          "Workspace List Folders"
        )
        -- Diagnostic
        nmap("<leader>dl", vim.diagnostic.setloclist, "Diagnostic Setloclist")

        -- The following two `autocommands` are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second `autocommand`).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- `stevearc/conform.nvim` changes the `formatexpr` value, but at least for
        -- `lua`, this fucks up the `gq<mothion>` command, at least on comments. The
        -- empty string sets the default, which hopefully works fine in other languages
        -- as well. Let's see.
        vim.o.formatexpr = ""
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP Specification.
    --  When you add `nvim-cmp`, `luasnip`, etc. Neovim now has *more* capabilities. So,
    --  we create new capabilities with `nvim-cmp`, and then broadcast that to the
    --  servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("blink.cmp").get_lsp_capabilities(capabilities)
    )
    -- TODO: Maybe include this, maybe not

    local config = {
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "▲",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "󰈻",
        },
      },
      update_in_insert = true,
      underline = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        source = "always",
      },
    }
    vim.diagnostic.config(config)

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`tsserver`) will work just fine
      -- tsserver = {},
      --

      harper_ls = require("engeir.lazy.plugins.lsp.lspconfig-settings.harper-ls"),
      jsonls = require("engeir.lazy.plugins.lsp.lspconfig-settings.jsonls"),
      lua_ls = require("engeir.lazy.plugins.lsp.lspconfig-settings.lua_ls"),
      texlab = require("engeir.lazy.plugins.lsp.lspconfig-settings.texlab"),
      tinymist = require("engeir.lazy.plugins.lsp.lspconfig-settings.tinymist"),
      yamlls = require("engeir.lazy.plugins.lsp.lspconfig-settings.yamlls"),
      -- pylsp = require("engeir.lazy.plugins.lsp.lspconfig-settings.pylsp"),
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu
    require("mason").setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format `lua` code
    })
    -- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed by the server
          -- configuration above. Useful when disabling certain features of an LSP (for
          -- example, turning off formatting for `tsserver`)
          server.capabilities =
            vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}

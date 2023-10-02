return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        -- NOTE: this must be here, so that Mason config is run before this
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lspconf = require("lspconfig")
        local mason_lspconf = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Diagnostics
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open Float Diagnostics" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto Next Diagnostics" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto Prev Diagnostics" })
        vim.keymap.set("n", "gsl", vim.diagnostic.setloclist, { desc = "[g] [S]et[l]oclist" })

        local on_attach = function(client, bufnr)
            local map = function(mode, keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end
                vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
            end
            local nmap = function(keys, func, desc)
                map("n", keys, func, desc)
            end
            local imap = function(keys, func, desc)
                map("i", keys, func, desc)
            end
            local xmap = function(keys, func, desc)
                map("x", keys, func, desc)
            end

            -- Keymaps inspired by kickstart.nvim + lsp-zero
            -- All default mapping set by lsp-zero:
            -- https://github.com/VonHeikemen/lsp-zero.nvim/issues/15#issuecomment-1128842548

            nmap("<leader>rs", "<cmd>LspRestart", "Lsp [R]e[s]tart")
            nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
            xmap("<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", "Range [C]ode [A]ction")

            nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
            nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            -- Telescope alternative to vim.lsp.buf.references
            nmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
            nmap("<leader>gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
            nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
            nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

            -- See `:help K` for why this keymap
            nmap("K", vim.lsp.buf.hover, "Hover Documentation")
            nmap("<C-h>", vim.lsp.buf.signature_help, "Signature Documentation")
            imap("<C-h>", vim.lsp.buf.signature_help, "Signature Documentation")

            -- Lesser used LSP functionality
            nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
            nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
            nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbol")
            nmap("<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, "[W]orkspace [L]ist Folders")


            -- stevearc/conform.nvim changes the formatexpr value, but at least for lua,
            -- this fucks up the gq<mothion> command, at least on comments. The empty
            -- string sets the default, which hopefully works fine in other languages as
            -- well. Let's see.
            vim.o.formatexpr = ""
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()
        local signs = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "▲" },
            { name = "DiagnosticSignHint", text = "󰈻" },
            { name = "DiagnosticSignInfo", text = "" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end
        local config = {
            virtual_text = false, -- disable virtual text
            signs = {
                active = signs,   -- show signs
            },
            update_in_insert = true,
            underline = false,
            severity_sort = true,
            float = {
                focusable = true,
                style = "minimal",
                -- border = "rounded",
                source = "always",
                -- header = "",
                -- prefix = "",
            },
        }
        vim.diagnostic.config(config)

        -- This takes care of all installed by Mason manually, and that use default
        -- settings
        mason_lspconf.setup_handlers({
            function(server_name)
                lspconf[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    -- settings = servers[server_name],
                    -- filetypes = (servers[server_name] or {}).filetypes,
                })
            end,
        })

        -- Not available from Mason
        -- lspconf["textlsp"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     settings = {
        --         textLSP = {
        --             language = "en-GB",
        --         },
        --     },
        -- })
        -- If some need specific setup functions, we override those here
        lspconf["texlab"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                -- https://github.com/latex-lsp/texlab/wiki/Configuration
                texlab = {
                    chktex = {
                        onEdit = true,
                        onOpenAndSave = true,
                    },
                    experimental = {
                        mathEnvironments = {
                            "align*",
                            "equation",
                        },
                    },
                    formatterLineLength = -1,
                    forwardSearch = {
                        executable = "zathura",
                    },
                    latexindent = { modifyLineBreaks = true },
                },
            },
        })

        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")
        lspconf["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
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
            },
        })
    end,
}

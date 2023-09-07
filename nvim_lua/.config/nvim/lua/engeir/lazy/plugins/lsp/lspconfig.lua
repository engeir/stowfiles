return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
        local lspconf = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

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

            -- Diagnostics
            nmap("gl", vim.diagnostic.open_float, "Open Float Diagnostics")
            nmap("[d", vim.diagnostic.goto_prev, "Goto Next Diagnostics")
            nmap("]d", vim.diagnostic.goto_next, "Goto Prev Diagnostics")
            nmap("gsl", vim.diagnostic.setloclist, "[g] [S]et[l]oclist")

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

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                if vim.lsp.buf.format then
                    vim.lsp.buf.format({ timeout_ms = 5000 })
                elseif vim.lsp.buf.formatting then
                    vim.lsp.buf.formatting({ timeout_ms = 5000 })
                end
            end, { desc = "Format current buffer with LSP" })
            nmap("<leader>s", "<cmd>Format<CR>", "Format")
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local signs = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "▲" },
            { name = "DiagnosticSignHint", text = "" },
            { name = "DiagnosticSignInfo", text = "" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end

        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")
        lspconf["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = runtime_path,
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,
}

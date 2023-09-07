return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline",     event = { "CmdlineEnter" } },
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-calc" },
            -- Icons for the LSP cmp view
            { "onsails/lspkind.nvim" },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            local opts = {
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                -- From TJ
                -- https://github.com/tjdevries/config_manager/blob/78608334a7803a0de1a08a9a4bd1b03ad2a5eb11/xdg_config/nvim/after/plugin/completion.lua#L129
                sorting = {
                    -- TODO: Would be cool to add stuff like "See variable names before method
                    -- names" in rust, or something like that.
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,

                        -- copied from cmp-under, but I don't think I need the plugin for this. I
                        -- might add some more of my own.
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find("^_+")
                            local _, entry2_under = entry2.completion_item.label:find("^_+")
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0
                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,

                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                formatting = {
                    -- Youtube: How to set up nice formatting for your sources.
                    format = lspkind.cmp_format({
                        with_text = true,
                        menu = {
                            buffer = "[buf]",
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[api]",
                            path = "[path]",
                            luasnip = "[snip]",
                            gh_issues = "[issues]",
                            tn = "[TabNine]",
                            eruby = "[erb]",
                        },
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-f>"] = cmp.mapping.scroll_docs(-4), -- Up
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Down
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                }),
                sources = {
                    { name = "calc" },
                    { name = "gh_issues" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "luasnip" }, -- For luasnip users.
                    { name = "buffer",   keyword_length = 4 },
                    -- { name = "orgmode" },
                    -- { name = "cmp_tabnine" },
                },
                view = {
                    entries = "native_menu",
                },
                experimental = {
                    ghost_text = true,
                },
            }
            cmp.setup(opts)
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })
            if EXECUTABLE("gh") then
                require("engeir.lazy.lsp.cmp_gh_source")
            end
        end,
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        event = { "BufReadPre", "BufNewFile" },
        build = "make install_jsregexp",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
            require("engeir.lazy.lsp.luasnip-settings")
        end,
    },

    -- Extra
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local ok, null_ls = pcall(require, "null-ls")
            if not ok then
                return
            end

            -- Nice:
            -- https://github.com/jose-elias-alvarez/null-ls.nvim#parsing-cli-program-output
            local check_exit_code = function(code, stderr)
                local success = code < 1

                if not success then
                    -- can be noisy for things that run often (e.g. diagnostics), but can
                    -- be useful for things that run on demand (e.g. formatting)
                    print(stderr)
                end

                return success
            end

            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
            local formatting = null_ls.builtins.formatting
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            local diagnostics = null_ls.builtins.diagnostics
            -- local code_actions = null_ls.builtins.code_actions

            local h = require("null-ls.helpers")
            -- This works ...
            local shellcheck_formatter = {
                name = "shellcheck",
                method = null_ls.methods.FORMATTING,
                filetypes = { "sh" },
                generator = null_ls.formatter({
                    command = "sh",
                    args = { "-c", "shellcheck $0 --format=diff | patch $0 -o-", "$FILENAME" },
                    to_stdin = true,
                    from_stderr = true,
                    check_exit_code = check_exit_code,
                }),
            }
            null_ls.register(shellcheck_formatter)
            local blackd = {
                name = "blackd",
                method = null_ls.methods.FORMATTING,
                filetypes = { "python" },
                generator = h.formatter_factory({
                    command = "blackd-client",
                    to_stdin = true,
                    check_exit_code = check_exit_code,
                }),
            }
            -- local function dprint_config()
            --     local lsputil = require("lspconfig.util")
            --     local path = lsputil.path.join(vim.loop.cwd(), "dprint.json")
            --     print(path)
            --     if lsputil.path.exists(path) then
            --         print("path exists")
            --         return path
            --     end
            --     print("path doesnt exist")
            --     return vim.fn.expand("~/.config/dprint/dprint.json")
            -- end
            local dprint = {
                name = "dprint",
                method = null_ls.methods.FORMATTING,
                filetypes = {
                    "json",
                    "markdown",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "toml",
                    "dockerfile",
                    "css",
                },
                generator = h.formatter_factory({
                    command = "dprint",
                    -- condition = function(utils)
                    --     return utils.root_has_file 'dprint.json'
                    -- end,
                    args = {
                        "fmt",
                        "--config",
                        -- dprint_config(),
                        -- require('lspconfig.util').path.join(
                        --     vim.loop.cwd(),
                        --     'dprint.json'
                        -- ),
                        vim.fn.expand("~/.config/dprint/dprint.jsonc"),
                        "--stdin",
                        "$FILEEXT",
                    },
                    to_stdin = true,
                    check_exit_code = check_exit_code,
                }),
            }
            -- https://github.com/prettier-solidity/prettier-plugin-solidity
            null_ls.setup({
                -- debug = true,
                -- Stopped working all of a sudden. Crashes `gq<motion>`.
                sources = {
                    -- code_actions.gitsigns,
                    -- code_actions.proselint,
                    -- code_actions.refactoring,
                    -- diagnostics.flake8,
                    diagnostics.golangci_lint,
                    diagnostics.jsonlint,
                    diagnostics.rstcheck,
                    diagnostics.markdownlint.with({
                        extra_args = { "-c", vim.fn.expand("~") .. "/.config/mdl/.markdownlint.jsonc" },
                    }),
                    diagnostics.mypy,
                    diagnostics.vale,
                    diagnostics.chktex,
                    -- diagnostics.pydocstyle,
                    diagnostics.shellcheck,
                    formatting.beautysh,
                    formatting.bibclean.with({ extra_args = { "--max-width", "0" } }),
                    -- formatting.black.with({ extra_args = { "--fast" } }),
                    blackd,
                    dprint,
                    formatting.fixjson,
                    formatting.fprettify,
                    formatting.gofmt,
                    formatting.isort,
                    formatting.latexindent.with({
                        extra_args = { "-m" },
                    }),
                    -- formatting.markdownlint.with({
                    --     extra_args = { "-c", vim.fn.expand("~") .. "/.config/mdl/.markdownlint.jsonc" },
                    -- }), -- Using `prettierd` instead
                    formatting.prettierd.with({
                        filetypes = { "css", "yml", "yaml", "toml" },
                        -- args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
                    }),
                    formatting.ruff,
                    formatting.shellharden,
                    formatting.shfmt.with({ extra_args = { "-i=4" } }),
                    formatting.stylua.with({ extra_args = { "--indent-type=Spaces" } }),
                    formatting.taplo,
                },
            })

            -- null-ls has an issue with gqq when an lsp is attached, but the below solves it. See:
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1259
            -- Use internal formatting for bindings like gq.
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    vim.bo[args.buf].formatexpr = nil
                end,
            })
        end,
    },
    {
        "iurimateus/luasnip-latex-snippets.nvim",
        -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
        -- using treesitter.
        dependencies = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("luasnip-latex-snippets").setup({ use_treesitter = true })
        end,
        -- treesitter is required for markdown
        ft = { "tex", "markdown" },
    },
}

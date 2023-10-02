return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline", event = { "CmdlineEnter" } },
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
                    ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
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
                    { name = "luasnip" }, -- For luasnip users.
                    { name = "path" },
                    { name = "buffer", keyword_length = 4 },
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
                require("engeir.lazy.plugins.lsp.cmp-sources.cmp_gh_source")
            end
        end,
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        event = { "BufReadPre", "BufNewFile" },
        build = "make install_jsregexp",
        -- dependencies = "rafamadriz/friendly-snippets",
        dependencies = "iurimateus/luasnip-latex-snippets.nvim",
        config = function()
            -- See https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
            -- and teeeej's taketuesday #3 videos for more sweetness
            local ls = require("luasnip")
            local types = require("luasnip.util.types")
            ls.setup({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { "<-", "Error" } },
                        },
                    },
                },
                snip_env = {
                    parse_eval = function(...)
                        local snip = ls.parser.parse_snipmate(...)
                        table.insert(getfenv(2).ls_file_snippets, snip)
                    end,
                },
            })
            vim.keymap.set({ "i", "s" }, "<c-k>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })
            -- Jump backward <c-j> (default is just to create a newline)
            vim.keymap.set({ "i", "s" }, "<c-j>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
            -- <c-l> is for selecting within a list of options.
            -- Useful for choice nodes (introduced in the second luasnip tutorial by teeeej)
            vim.keymap.set("i", "<c-l>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)
            vim.keymap.set("n", "<leader><leader>s", function()
                require("luasnip.loaders").edit_snippet_files()
            end, { desc = "LuaSnip: Source Snippets File" })

            -- require("luasnip.loaders.from_vscode").lazy_load({
            --     paths = { "~/.config/nvim/lua/engeir/lazy/plugins/lsp/luasnippets/vscode/" },
            -- })
            -- require("luasnip.loaders.from_vscode").lazy_load({
            --     exclude = { "latex", "tex", "plaintex" },
            -- })
            require("luasnip.loaders.from_lua").load({
                paths = "~/.config/nvim/lua/engeir/lazy/plugins/lsp/luasnippets/lua/",
            })
        end,
    },

    -- Extra
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

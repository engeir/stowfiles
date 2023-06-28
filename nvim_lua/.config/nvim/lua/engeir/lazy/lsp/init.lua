local ok, lsp, lspconfig, cmp, luasnip, lspkind = pcall(function()
    return require("lsp-zero"), require("lspconfig"), require("cmp"), require("luasnip"), require("lspkind")
end)
if not ok then
    return
end

-- null-ls settings
require("engeir.lazy.lsp.null-ls")
require("neodev").setup()

-- ==================================== LSP-ZERO ==================================== --
local lsp_pre = lsp.preset("recommended")
lsp.set_preferences({
    set_lsp_keymaps = false,
})
lsp.nvim_workspace()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp_pre.on_attach(function(_, bufnr)
    lsp_pre.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false,
    })
    local map = function(mode, keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
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
end)

-- ============================ CUSTOM SERVER SETTINGS ============================== --
-- Set up specific LSPs. They seem to work, but not sure if it's the intended way by
-- lsp-zero.
local opts = {
    on_attach = require("engeir.lazy.lsp.handlers").on_attach,
    capabilities = require("engeir.lazy.lsp.handlers").capabilities,
}
lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", require("engeir.lazy.lsp.languages.lua_ls"), opts))
-- The most complete and best when it comes to features, but increadibly slow
-- lspconfig.pyright.setup(vim.tbl_deep_extend("force", require("engeir.lazy.lsp.languages.pyright"), opts))
-- pylsp and jedi are so similar I almost can't tell the difference atm, but jedi has
-- better snippet-like expansion of functions. pylsp also uses YAPF to format the code,
-- which differ from black and confuses the auto-formatter.
-- lspconfig.pylsp.setup(vim.tbl_deep_extend("force", require("engeir.lazy.lsp.languages.pylsp"), opts))
-- lspconfig.jedi_language_server.setup(opts)
-- This might take over for jedi_language_server, but while the GoTo Definition, Rename,
-- etc., is not working, this is not an option. Maybe I actually have to, since
-- auto-import is not included in jedi_language_server. But, turns out pylyzer somehow
-- overrides the tab, so that pressing it chooses from the cmp list. It also opens cmp
-- on empty lines, which is super annoying and intrusive.
-- lspconfig.pylyzer.setup(opts)
lspconfig.ruff_lsp.setup(opts)
-- lspconfig.ltex.setup(vim.tbl_deep_extend("force", require("engeir.lazy.lsp.languages.ltex"), opts))
if EXECUTABLE("pass") then
    lspconfig.sourcery.setup(vim.tbl_deep_extend("force", require("engeir.lazy.lsp.languages.sourcery"), opts))
end

lsp_pre.setup()

-- ====================================== CMP ======================================= --
-- This inputs the text as it is highlighted, and thus there is no need for
-- confirmation.
-- https://github.com/hrsh7th/nvim-cmp
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "✂️",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
cmp.setup({
    completion = {
        completeopt = "menuone,noselect",
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
    mapping = lsp.defaults.cmp_mappings({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
})
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})
-- `:` cmdline setup.
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

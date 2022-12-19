local ok, lsp, lspconfig, cmp, luasnip = pcall(function()
    return require("lsp-zero"), require("lspconfig"), require("cmp"), require("luasnip")
end)
if not ok then
    return
end

-- null-ls settings
require("engeir.lsp.null-ls")

-- ==================================== LSP-ZERO ==================================== --
lsp.preset("recommended")
lsp.set_preferences({
    set_lsp_keymaps = false,
})
lsp.nvim_workspace()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.on_attach(function(_, bufnr)
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
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "Format current buffer with LSP" })
    nmap("<leader>s", "<cmd>Format<CR>", "Format")
end)

-- ============================ CUSTOM SERVER SETTINGS ============================== --
-- Set up specific LSPs. They seem to work, but not sure if it's the intended way by
-- lsp-zero.
local opts = {
    on_attach = require("engeir.lsp.handlers").on_attach,
    capabilities = require("engeir.lsp.handlers").capabilities,
}
lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", require("engeir.lsp.settings.sumneko_lua"), opts))
lspconfig.pyright.setup(vim.tbl_deep_extend("force", require("engeir.lsp.settings.pyright"), opts))
lspconfig.ltex.setup(vim.tbl_deep_extend("force", require("engeir.lsp.settings.ltex"), opts))
if EXECUTABLE("pass") then
    lspconfig.sourcery.setup(vim.tbl_deep_extend("force", require("engeir.lsp.settings.sourcery"), opts))
end

lsp.setup()

-- ====================================== CMP ======================================= --
-- This inputs the text as it is highlighted, and thus there is no need for
-- confirmation.
-- https://github.com/hrsh7th/nvim-cmp
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
cmp.setup({
    completion = {
        completeopt = "menuone,noselect",
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
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
        { name = "gh_issues" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "buffer", keyword_length = 4 },
        -- { name = "orgmode" },
        -- { name = "copilot" },
        -- { name = "cmp_tabnine" },
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

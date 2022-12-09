local ok, lsp, cmp, luasnip = pcall(function()
    return require("lsp-zero"), require("cmp"), require("luasnip")
end)
if not ok then
    return
end

require("engeir.lsp.null-ls")
lsp.preset("recommended")
lsp.nvim_workspace()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- lsp.on_attach(function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--     local keymap = vim.keymap.set
--     -- keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--     keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--     -- keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--     keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--     keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--     keymap("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--     -- keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--     keymap("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
--     -- keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
--     keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
--     keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
--     keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
--     keymap("n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
--     keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
--     keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--     -- keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
--     -- keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
--     -- keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
--     keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--     -- keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--     keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
--     -- keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
--     keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
--     -- keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
--     keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
--     -- keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
--     keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
--     -- keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
--     keymap("n", "<leader>s", "<cmd>lua vim.lsp.buf.format({ async=true})<CR>", opts)
--     -- keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
--     keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
--     keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
-- end)
lsp.on_attach(function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("<leader>gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-h>", vim.lsp.buf.signature_help, "Signature Documentation")
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
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

lsp.setup()

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

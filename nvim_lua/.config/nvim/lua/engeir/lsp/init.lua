local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.nvim_workspace()
local ok, cmp = pcall(require, "cmp")
if not ok then
    return
end
local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
--     ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
--     ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--     ["<C-Space>"] = cmp.mapping.complete(),
--     ["<CR>"] = cmp.config.disable,
-- })
--
-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings
-- })

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
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    vim.keymap.set('i', "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbol")
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end)

lsp.setup()

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    mapping = lsp.defaults.cmp_mappings({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })
})

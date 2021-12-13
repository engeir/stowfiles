local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
  },
  completion = {
    autocomplete = false,
    completeopt = 'menu,menuone,noinsert',
  },
  sources = {
    -- { name = 'gh_issues' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 4 },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  }
})

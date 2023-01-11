local ok, neogen = pcall(require, "neogen")
if not ok then
    return
end

neogen.setup({
    snippet_engine = "luasnip",
    languages = {
        python = {
            template = {
                annotation_convention = "numpydoc",
            },
        },
    },
})
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gp", ":lua require('neogen').generate()<CR>", opts)

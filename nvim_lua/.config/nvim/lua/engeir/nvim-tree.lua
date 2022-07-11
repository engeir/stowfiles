local ok, tree = pcall(require, "nvim-tree")
if not ok then
    return
end

tree.setup({
    disable_netrw = true,
    view = {
        side = "right",
        width = 60,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
})

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap("n", "<leader>pp", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>pf", ":NvimTreeFindFile<CR>", opts)

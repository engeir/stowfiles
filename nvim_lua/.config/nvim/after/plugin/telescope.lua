-- Define keymappings for original telescope plugin
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>")
map("n", "<leader>fl", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
map("n", "<leader>fs", "<cmd>lua require('telescope.builtin').git_files({cwd='~/stowfiles/'})<cr>")
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').git_files()<cr>")
map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers({sort_mru=true, ignore_current_buffer=true})<cr>")
map("n", "<leader>fb", "<cmd>Telescope bibtex<cr>")
map("n", "<leader>fp", "<cmd>Telescope spell_suggest<cr>")
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
map("n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>")
map("n", "<leader>fo", "<cmd>lua require('telescope.builtin').git_commits()<cr>")
map("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>")

require("telescope").setup({
    defaults = {
        path_display = { shorten = 3 },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",
            "--smart-case",
        },
    },
    extensions = {
        bibtex = {
            -- Path to global bibliographies (placed outside of the project)
            global_files = { "/home/een023/science/ref/ref.bib" },
            -- Context awareness disabled by default
            context = true,
            -- Fallback to global/directory .bib files if context not found
            -- This setting has no effect if context = false
            context_fallback = true,
        },
    },
})

-- Load the bibtex extension
require("telescope").load_extension("bibtex")

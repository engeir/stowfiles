local is_known = (function()
    local output = vim.fn.systemlist("uname -n")
    local known = { "ubuntu-work", "eenMBP.local" }
    for _, v in ipairs(known) do
        if v == output[1] then
            return true
        end
    end
    return false
end)()
local has = function(x)
    return vim.fn.has(x) == 1
end
local is_wsl = (function()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end)()
local is_mac = has("macunix")
local is_linux = not is_wsl and not is_mac
-- Define keymappings for original telescope plugin
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            -- filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "fdfind", -- find command (defaults to `fd`)
        },
    },
})

-- Load extensions
-- require("telescope-media-files").setup()
require("telescope").load_extension("bibtex")
if is_linux and is_known then
    require("telescope").load_extension("media_files")
end

map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>")
map("n", "<leader>fl", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
map("n", "<leader>fs", "<cmd>lua require('telescope.builtin').git_files({cwd='~/stowfiles/'})<cr>")
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').git_files()<cr>")
map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers({sort_mru=true, ignore_current_buffer=true})<cr>")
map("n", "<leader>fb", "<cmd>Telescope bibtex<cr>")
map("n", "<leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>")
map("n", "<leader>fp", "<cmd>Telescope spell_suggest<cr>")
map("n", "<leader>fv", "<cmd>Telescope neoclip<cr>")
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
map("n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>")
map("n", "<leader>fo", "<cmd>lua require('telescope.builtin').git_commits()<cr>")
map("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>")

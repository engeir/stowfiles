local list = [[
<< EOF
:PackerInstall
:Telescope find_files
:Git blame
EOF
]]

return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            -- Define keymappings for original telescope plugin
            local function map(mode, lhs, rhs, opts)
                local options = { noremap = true, silent = true }
                if opts then
                    options = vim.tbl_extend("force", options, opts)
                end
                vim.api.nvim_set_keymap(mode, lhs, rhs, options)
            end

            -- Don't preview binaries
            -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries
            local previewers = require("telescope.previewers")
            local Job = require("plenary.job")
            local new_maker = function(filepath, bufnr, opts)
                filepath = vim.fn.expand(filepath)
                Job:new({
                    command = "file",
                    args = { "--mime-type", "-b", filepath },
                    on_exit = function(j)
                        local mime_type = vim.split(j:result()[1], "/")[1]
                        if mime_type == "text" then
                            previewers.buffer_previewer_maker(filepath, bufnr, opts)
                        else
                            -- maybe we want to write something to the buffer here
                            vim.schedule(function()
                                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                            end)
                        end
                    end,
                }):sync()
            end

            require("telescope").setup({
                defaults = {
                    buffer_previewer_maker = new_maker,
                    path_display = { shorten = 3 },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--hidden",
                        -- "--smart-case",
                        "--trim",
                    },
                },
                pickers = {
                    grep_string = {
                        -- theme = "dropdown",
                        layout_strategy = "vertical",
                    },
                    live_grep = {
                        layout_strategy = "vertical",
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- more options
                        }),
                    },
                    bibtex = {
                        -- Path to global bibliographies (placed outside of the project)
                        global_files = { "/home/een023/science/ref/ref.bib" },
                        -- Context awareness disabled by default
                        context = true,
                        -- Fallback to global/directory .bib files if context not found
                        -- This setting has no effect if context = false
                        context_fallback = true,
                        -- Custom format for HTML referencing
                        custom_formats = {
                            {
                                id = "hackmd",
                                citation_format =
                                "[^@{{label}}]: {{author}}, '{{title}}', {{journal}}, {{year}}, vol. {{volume}}, no. {{number}}, p. {{pages}}.",
                                cite_marker = "[^@%s]",
                            },
                            -- {
                            --     id = "revealjs",
                            --     cite_marker = '<a href="https://doi.org/{{doi}}" data-citation-key="@{{label}}">{{author}} ({{year}})</a>',
                            --     citation_format = '<div class="csl-entry" id="ref-smith2010" role="doc-biblioentry"> {{author}}, {{title}}, {{journal}}, {{year}}, vol. {{volume}}, no. {{number}}, p. {{pages}}.</div>',
                            -- },
                        },
                        format = "hackmd",
                        citation_format =
                        "{{author}}, '{{title}}', {{journal}}, {{year}}, vol. {{volume}}, no. {{number}}, p. {{pages}}.",
                        -- citation_format = '<a href="https://doi.org/{{doi}}" data-citation-key="@{{label}}">{{author}} ({{year}})</a>',
                    },
                    media_files = {
                        -- filetypes whitelist
                        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                        -- filetypes = { "png", "webp", "jpg", "jpeg" },
                        -- find_cmd = "fd", -- find command (defaults to `fd`)
                    },
                },
            })

            map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>")
            map("n", "<leader>fl", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
            map("n", "<leader>fs", "<cmd>lua require('telescope.builtin').git_files({cwd='~/stowfiles/'})<cr>")
            map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').git_files()<cr>") -- {git_command={'git', 'grep', '--cached', '-Il', '\"\"'}}
            map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
            map("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
            map(
                "n",
                "<leader>b",
                "<cmd>lua require('telescope.builtin').buffers({sort_mru=true, ignore_current_buffer=true})<cr>"
            )
            map("n", "<leader>fb", "<cmd>Telescope bibtex<cr>")
            map("n", "<leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>")
            map("n", "<leader>fp", "<cmd>Telescope spell_suggest<cr>")
            map("n", "<leader>fv", "<cmd>Telescope neoclip<cr>")
            map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
            map("n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>")
            map("n", "<leader>fo", "<cmd>lua require('telescope.builtin').git_commits()<cr>")
            map("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>")
        end,
    },
    {
        "axkirillov/easypick.nvim",
        config = function()
            local easypick = require("easypick")
            -- only required for the example to work
            local base_branch = "develop"
            -- a list of commands that you want to pick from
            easypick.setup({
                pickers = {
                    -- add your custom pickers here
                    -- below you can find some examples of what those can look like

                    {
                        name = "nobin",
                        command = 'git grep --cached -Il ""',
                        previewer = easypick.previewers.default(),
                    },
                    {
                        name = "command_palette",
                        command = "cat " .. list,
                        -- pass a pre-configured action that runs the command
                        action = easypick.actions.run_nvim_command,
                        -- you can specify any theme you want, but the dropdown looks good for this example =)
                        opts = require("telescope.themes").get_dropdown({}),
                    },

                    -- diff current branch with base_branch and show files that changed with respective diffs in preview
                    {
                        name = "changed_files",
                        command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
                        previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
                    },

                    -- list files that have conflicts with diffs in preview
                    {
                        name = "conflicts",
                        command = "git diff --name-only --diff-filter=U --relative",
                        previewer = easypick.previewers.file_diff(),
                    },
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope-bibtex.nvim",
        enabled = IS_KNOWN,
        config = function()
            require("telescope").load_extension("bibtex")
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup({ default_register = { '"', "+", "*" } })
            require("telescope").load_extension("neoclip")
        end,
    },
    "nvim-telescope/telescope-symbols.nvim",
    {
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = { "nvim-lua/popup.nvim" },
        enabled = IS_KNOWN,
        cond = IS_LINUX,
        config = function()
            require("telescope").load_extension("media_files")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        enabled = IS_KNOWN,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")
        end,
    },
}

local list = [[
<< EOF
:Telescope find_files
:Git blame
EOF
]]

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
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

            local actions = require("telescope.actions")
            local trouble = require("trouble.providers.telescope")
            local telescope = require("telescope")
            local state = require("telescope.state")
            local action_state = require("telescope.actions.state")

            -- From https://github.com/nvim-telescope/telescope.nvim/issues/2602#issuecomment-1636809235
            local slow_scroll = function(prompt_bufnr, direction)
                local previewer = action_state.get_current_picker(prompt_bufnr).previewer
                local status = state.get_status(prompt_bufnr)

                -- Check if we actually have a previewer and a preview window
                if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
                    return
                end

                previewer:scroll_fn(1 * direction)
            end
            telescope.setup({
                defaults = {
                    generic_sorter = require("mini.fuzzy").get_telescope_sorter,
                    file_sorter = require("mini.fuzzy").get_telescope_sorter,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-j>"] = function(bufnr)
                                slow_scroll(bufnr, 1)
                            end,
                            ["<C-k>"] = function(bufnr)
                                slow_scroll(bufnr, -1)
                            end,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<c-t>"] = trouble.open_with_trouble,
                        },
                        n = { ["<c-t>"] = trouble.open_with_trouble },
                    },
                    buffer_previewer_maker = new_maker,
                    path_display = { shorten = 4 },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--hidden",
                        "--smart-case",
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
                                citation_format = "[^@{{label}}]: {{author}}, '{{title}}', {{journal}}, {{year}}, vol. {{volume}}, no. {{number}}, p. {{pages}}.",
                                cite_marker = "[^@%s]",
                            },
                            -- {
                            --     id = "revealjs",
                            --     cite_marker = '<a href="https://doi.org/{{doi}}" data-citation-key="@{{label}}">{{author}} ({{year}})</a>',
                            --     citation_format = '<div class="csl-entry" id="ref-smith2010" role="doc-biblioentry"> {{author}}, {{title}}, {{journal}}, {{year}}, vol. {{volume}}, no. {{number}}, p. {{pages}}.</div>',
                            -- },
                        },
                        format = "hackmd",
                        citation_format = "{{author}}, '{{title}}', {{journal}}, {{year}}, vol. {{volume}}, no. {{number}}, p. {{pages}}.",
                        -- citation_format = '<a href="https://doi.org/{{doi}}" data-citation-key="@{{label}}">{{author}} ({{year}})</a>',
                    },
                    media_files = {
                        -- filetypes whitelist
                        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                        filetypes = { "png", "jpg", "jpeg", "webp", "webm", "svg", "mp4", "mov", "epub" },
                        -- find_cmd = "fd", -- find command (defaults to `fd`)
                    },
                },
            })

            telescope.load_extension("fzf")

            vim.keymap.set("n", "<leader>ff", function()
                require("telescope.builtin").find_files({ hidden = true })
            end, { desc = "[F]ind [F]iles" })
            vim.keymap.set("n", "<leader>fl", function()
                require("telescope.builtin").current_buffer_fuzzy_find()
            end, { desc = "[F]ind [L]ines" })
            vim.keymap.set("n", "<leader>fs", function()
                require("telescope.builtin").git_files({ cwd = "~/stowfiles/" })
            end, { desc = "[F]ind [S]towfiles" })
            vim.keymap.set("n", "<leader>fg", function()
                require("telescope.builtin").git_files()
            end, { desc = "[F]ind [G]itfiles" }) -- {git_command={'git', 'grep', '--cached', '-Il', '\"\"'}}
            -- map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').live_grep()<cr>") -- Does not fuzzy
            vim.keymap.set("n", "<leader>fr", function()
                require("telescope.builtin").grep_string({ search = "" })
            end, { desc = "[F]ind [R]ipgrep (find string)" })
            vim.keymap.set("n", "<leader>fw", function()
                require("telescope.builtin").grep_string()
            end, { desc = "[F]ind [W]ord under cursor" })
            vim.keymap.set("n", "<leader>b", function()
                require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
            end, { desc = "Find [B]uffers" })
            vim.keymap.set("n", "<leader>fp", function()
                require("telescope.builtin").spell_suggest()
            end, { desc = "[F]ind S[p]ell suggestions" })
            -- map("n", "<leader>fv", "<cmd>Telescope neoclip<cr>", { desc = "[F]ind from clipboard registers" })
            vim.keymap.set("n", "<leader>fh", function()
                require("telescope.builtin").help_tags()
            end, { desc = "[F]ind [H]elp tags" })
            vim.keymap.set("n", "<leader>fc", function()
                require("telescope.builtin").commands()
            end, { desc = "[F]ind [C]ommands" })
            vim.keymap.set("n", "<leader>fo", function()
                require("telescope.builtin").git_commits()
            end, { desc = "[F]ind C[o]mmits" })
            vim.keymap.set("n", "<leader>fk", function()
                require("telescope.builtin").keymaps()
            end, { desc = "[F]ind [K]eymaps" })
        end,
    },
    {
        "axkirillov/easypick.nvim",
        cmd = "Easypick",
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
        ft = "tex",
        keys = {
            { "<leader>fb", "<cmd>Telescope bibtex<cr>", { desc = "[F]ind [B]ibtex" } },
        },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "AckslD/nvim-neoclip.lua",
        enabled = false,
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
        keys = {
            {
                "<leader>fm",
                function()
                    require("telescope").extensions.media_files.media_files()
                end,
                desc = "[F]ind [M]edia files",
            },
        },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        enabled = false,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")
        end,
    },
}

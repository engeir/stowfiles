return {
    "goolord/alpha-nvim",
    enabled = false,
    config = function()
        -- Shamelessly copied from TSuzat (https://github.com/Tsuzat/nvim/blob/main/lua/user/alpha.lua)
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[               ██╗]],
            [[             ██╔═██╗]],
            [[   ██████╗   ██║ ██║ ██╗]],
            [[   ╚═════╝   ╚═██╔═╝ ██║]],
            [[ ██████╗   ██████████╔═╝]],
            [[ ╚═════╝   ██╔═██╔═══╝]],
            [[ ██████╗   ██║ ██║]],
            [[ ╚═════╝   ╚═╝ ██║]],
            [[ ██████╗ ████╗ ██████╗]],
            [[ ╚═════╝ ╚═██║ ██║ ██║]],
            [[   ██████╗ ██████║ ██║]],
            [[   ╚═════╝ ╚═════╝ ████╗]],
            [[                   ╚═══╝]],
        }
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", "<cmd>lua require'engeir.lazy.telescope.telescope-extra'.project_files()<cr>"),
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("d", "  Edit TODO", ":e ~/Documents/notes_papers/_includes/todo.md <CR>"),
            dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("t", "  Find text", "<cmd>lua require('telescope.builtin').live_grep()<cr>"),
            dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        local function footer()
            -- NOTE: requires the fortune-mod package to work
            -- local handle = io.popen("fortune")
            -- local fortune = handle:read("*a")
            -- handle:close()
            -- return fortune
            local handle = io.popen("nvim --version")
            if handle == nil then
                return "Nvim Config by @engeir"
            end
            local result = "Config by @engeir — " .. string.match(handle:read("*a"), "NVIM v[^\n]*")
            handle:close()
            return result
        end

        dashboard.section.footer.val = footer()

        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"

        dashboard.opts.opts.noautocmd = true
        -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
        alpha.setup(dashboard.opts)
    end,
}
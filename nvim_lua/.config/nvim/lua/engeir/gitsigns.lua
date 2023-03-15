local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

gitsigns.setup({
    current_line_blame = true,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
            if vim.wo.diff then
                return "]h"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Gitsigns: Goto Next Hunk" })

        map("n", "[h", function()
            if vim.wo.diff then
                return "[h"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Gitsigns: Goto Prev Hunk" })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Gitsigns: Stage Hunk" })
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Gitsigns: Reset Hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Gitsigns: Stage Buffer Hunks" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Gitsigns: Undo Stage Hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Gitsigns: Reset Buffer Hunks" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns: Preview Hunks" })
        map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
        end, { desc = "Gitsigns: Blame Line" })
        map("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Gitsigns: Toggle Line Blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Gitsigns: Diff This" })
        map("n", "<leader>hD", function()
            gs.diffthis("~")
        end, { desc = "Gitsigns: Diff This from HOME" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Gitsigns: Toggle Deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
})

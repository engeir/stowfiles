return {
  {
    "tpope/vim-fugitive",
    enabled = IS_KNOWN,
    cmd = "Git",
    keys = { { "gb", ":Git blame<CR>", desc = "[G]it [B]lame" } },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align",
        delay = 0,
      },
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
        map(
          { "n", "v" },
          "<leader>hs",
          ":Gitsigns stage_hunk<CR>",
          { desc = "Gitsigns: Stage Hunk" }
        )
        map(
          { "n", "v" },
          "<leader>hr",
          ":Gitsigns reset_hunk<CR>",
          { desc = "Gitsigns: Reset Hunk" }
        )
        map(
          "n",
          "<leader>hS",
          gs.stage_buffer,
          { desc = "Gitsigns: Stage Buffer Hunks" }
        )
        map(
          "n",
          "<leader>hu",
          gs.undo_stage_hunk,
          { desc = "Gitsigns: Undo Stage Hunk" }
        )
        map(
          "n",
          "<leader>hR",
          gs.reset_buffer,
          { desc = "Gitsigns: Reset Buffer Hunks" }
        )
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns: Preview Hunks" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Gitsigns: Blame Line" })
        map(
          "n",
          "<leader>hB",
          gs.toggle_current_line_blame,
          { desc = "Gitsigns: Toggle Line Blame" }
        )
        map("n", "<leader>hd", gs.diffthis, { desc = "Gitsigns: Diff This" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "Gitsigns: Diff This from HOME" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Gitsigns: Toggle Deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    enabled = IS_KNOWN,
    config = function()
      require("diffview").setup({
        file_panel = {
          listing_style = "list",
        },
      })
    end,
    keys = {
      {
        "dc",
        ":DiffviewClose<cr>",
        { silent = true, noremap = true, desc = "[D]iffview [C]lose" },
      },
      {
        "do",
        ":DiffviewOpen<cr>",
        { silent = true, noremap = true, desc = "[D]iffview [O]pen" },
      },
    },
  },
  {
    "TimUntersberger/neogit",
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        integrations = {
          diffview = true,
        },
      })
    end,
    cmd = "Neogit",
    keys = {
      {
        "<leader>gs",
        function()
          require("neogit").open()
        end,
        desc = "Neogit Open",
      },
      {
        "<leader>gc",
        function()
          require("neogit").open({ "commit" })
        end,
        { desc = "Neogit Commit" },
      },
    },
  }, -- To commit quickly and view
  { "rhysd/committia.vim", enabled = IS_KNOWN },
  {
    "kdheepak/lazygit.nvim",
    enabled = IS_KNOWN and EXECUTABLE("lazygit"),
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open [L]azy[G]it" },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = IS_KNOWN,
    config = function()
      require("gitlinker").setup()
    end,
  }, -- Quickly get a permalink to lines of code
  -- My plugins
  {
    "engeir/githistory-browse.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
}

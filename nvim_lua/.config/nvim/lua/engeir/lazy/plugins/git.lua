return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      current_line_blame = false,
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
        map("n", "]g", function()
          if vim.wo.diff then return "]g" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Gitsigns: Goto Next Hunk" })

        map("n", "[g", function()
          if vim.wo.diff then return "[g" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Gitsigns: Goto Prev Hunk" })

        -- Actions
        map(
          { "n", "v" },
          "<leader>gs",
          ":Gitsigns stage_hunk<CR>",
          { desc = "Gitsigns: Stage Hunk" }
        )
        map(
          { "n", "v" },
          "<leader>gr",
          ":Gitsigns reset_hunk<CR>",
          { desc = "Gitsigns: Reset Hunk" }
        )
        map(
          "n",
          "<leader>gS",
          gs.stage_buffer,
          { desc = "Gitsigns: Stage Buffer Hunks" }
        )
        map(
          "n",
          "<leader>gu",
          gs.undo_stage_hunk,
          { desc = "Gitsigns: Undo Stage Hunk" }
        )
        map(
          "n",
          "<leader>gR",
          gs.reset_buffer,
          { desc = "Gitsigns: Reset Buffer Hunks" }
        )
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Gitsigns: Preview Hunks" })
        map(
          "n",
          "<leader>gb",
          function() gs.blame_line({ full = true }) end,
          { desc = "Gitsigns: Show Hover Blame Line" }
        )
        map(
          "n",
          "<leader>gB",
          gs.toggle_current_line_blame,
          { desc = "Gitsigns: Toggle Inline Blame" }
        )
        map("n", "<leader>gv", gs.diffthis, { desc = "Gitsigns: Diff View" })
        map(
          "n",
          "<leader>gV",
          function() gs.diffthis("~") end,
          { desc = "Gitsigns: Diff View from HOME" }
        )
        map("n", "<leader>gd", gs.toggle_deleted, { desc = "Gitsigns: Toggle Deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({
        file_panel = {
          listing_style = "list",
        },
      })
    end,
    keys = {
      {
        "<leader>gq",
        ":DiffviewClose<cr>",
        silent = true,
        noremap = true,
        desc = "Diffview Quit",
      },
      {
        "<leader>go",
        ":DiffviewOpen<cr>",
        silent = true,
        noremap = true,
        desc = "Diffview Open",
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
        "<leader>gg",
        function() require("neogit").open() end,
        desc = "Neogit Open",
      },
      {
        "<leader>gc",
        function() require("neogit").open({ "commit" }) end,
        desc = "Neogit Commit",
      },
    },
  }, -- To commit quickly and view
  { "rhysd/committia.vim", ft = "gitcommit" },
  {
    "isakbm/gitgraph.nvim",
    opts = {
      symbols = {
        merge_commit = "M",
        commit = "*",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit) print("selected commit:", commit.hash) end,
        on_select_range_commit = function(from, to)
          print("selected range:", from.hash, to.hash)
        end,
      },
    },
    keys = {
      {
        "<leader>gl",
        function() require("gitgraph").draw({}, { all = true, max_count = 5000 }) end,
        desc = "GitGraph - Draw",
      },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>gy",
        function() require("gitlinker").get_buf_range_url("n") end,
        desc = "Gitlinker Yank URL",
      },
    },
    config = function() require("gitlinker").setup() end,
  }, -- Quickly get a permalink to lines of code
  -- My plugins
  {
    "engeir/githistory-browse.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
}

-- Terminal Mappings
local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">"
      or vim.schedule(function() vim.cmd.wincmd(dir) end)
  end
end
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module "snacks.nvim"
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dim = { animate = { enabled = false } },
    notifier = { enabled = false },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          layout = { layout = { position = "right", width = 0.3 } },
        },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    styles = {
      scratch = { wo = { winhighlight = "NormalFloat:NormalFloat" }, border = "" },
    },
    words = { enabled = true },
  },
  keys = {
    { "crf", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    {
      "cps",
      function() Snacks.profiler.scratch() end,
      desc = "Profiler Scratch Bufer",
    },
    {
      "<leader>wts",
      function() Snacks.scratch.select() end,
      desc = "Select Scratch Buffer",
    },

    -- stylua: ignore start
    -- Trying out the picker module on `<leader>.`
    -- Top Pickers & Explorer
    { "<leader>.f", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>.b", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>.r", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>.:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>.n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>.e", function() Snacks.explorer() end, desc = "File Explorer" }, -- Duplicate
    -- Find
    { "<leader>.c", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>.F", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files" },
    { "<leader>.p", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>.l", function() Snacks.picker.recent() end, desc = "Recent / Lately" },
    -- Git
    { "<leader>.gf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>.gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>.gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>.gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>.gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>.gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>.gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>.gF", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    -- Grep
    { "<leader>.sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>.sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>.sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- Search
    { '<leader>.s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>.s/", function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>.sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>.sc", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>.sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>.sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>.sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>.sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>.si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>.sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>.sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>.sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>.sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>.sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>.sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>.sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>.sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>.su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>.sC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- LSP
    { "<leader>.hd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "<leader>.hD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "<leader>.hr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "<leader>.hI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "<leader>.hy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- stylua: ignore stop
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.dim():map("<leader>uf")
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle
          .option("relativenumber", { name = "Relative Number" })
          :map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        -- Snacks.toggle
        --   .option(
        --     "conceallevel",
        --     { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
        --   )
        --   :map("<leader>uc")  -- used by minty
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle
          .option("background", { off = "light", on = "dark", name = "Dark Background" })
          :map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.profiler():map("cpp")
        Snacks.toggle.profiler_highlights():map("cph")
      end,
    })
  end,
}

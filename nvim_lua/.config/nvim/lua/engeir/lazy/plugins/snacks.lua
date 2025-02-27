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
    { "<leader>pe", function() Snacks.explorer() end, desc = "File Explorer" },
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

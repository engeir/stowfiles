return {
  "ojroques/nvim-osc52",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("osc52").setup()
    vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
    vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
    vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)
    local function copy()
      if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
        require("osc52").copy_register("+")
      end
    end
    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
  end,
}

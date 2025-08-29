return {
  "mozanunal/sllm.nvim",
  enabled = function()
    vim.fn.system("ollama list >/dev/null 2>&1")
    return vim.v.shell_error == 0
  end,
  dependencies = {
    "nvim-mini/mini.notify",
    "nvim-mini/mini.pick",
  },
  opts = { default = "nhn-medium:latest" },
}

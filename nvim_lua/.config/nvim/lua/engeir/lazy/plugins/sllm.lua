return {
  "mozanunal/sllm.nvim",
  enabled = function()
    vim.fn.system("ollama list >/dev/null 2>&1")
    return vim.v.shell_error == 0
  end,
  dependencies = {
    "echasnovski/mini.notify",
    "echasnovski/mini.pick",
  },
  opts = { default = "nhn-medium:latest" },
}

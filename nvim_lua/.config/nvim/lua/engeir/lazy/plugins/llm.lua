return {
  -- This code block
  "huggingface/llm.nvim",
  enabled = function()
    vim.fn.system("timeout 0.4 ollama list >/dev/null 2>&1")
    return vim.v.shell_error == 0
  end,
  opts = {
    lsp = {
      bin_path = vim.api.nvim_call_function("stdpath", { "data" })
        .. "/mason/bin/llm-ls",
    },
    backend = "ollama",
    model = "nhn-large:latest",
    url = "http://localhost:22434", -- llm-ls uses "/api/generate"
    accept_keymap = "<C-y>",
    dismiss_keymap = "<C-e>",
    -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
    request_body = {
      -- Modelfile options for the model you use
      options = {
        temperature = 0.2,
        top_p = 0.95,
      },
    },
  },
}

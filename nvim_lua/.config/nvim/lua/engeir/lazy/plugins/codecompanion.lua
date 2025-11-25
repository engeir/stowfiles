return {
  "olimorris/codecompanion.nvim",
  keys = {
    {
      "<leader>cc",
      "<cmd>CodeCompanionChat<CR>",
      desc = "CodeCompanion Chat",
    },
  },
  enabled = true,
  -- function()
  --   vim.fn.system("timeout 0.4 ollama list >/dev/null 2>&1")
  --   return vim.v.shell_error == 0
  -- end,
  config = function()
    require("codecompanion").setup({
      system_prompt = function(opts)
        local file_path = os.getenv("HOME")
          .. "/stowfiles/nvim_lua/.config/nvim/lua/engeir/lazy/plugins/chatgpt/beast-mode-v2.md"
        local file = io.open(file_path, "r") -- Åpner filen med navnet "filnavn.md" for lesing
        if file then
          local content = file:read("*a") -- Leser inn hele filen som en streng
          file:close() -- Lukker filen
          return content -- Returnerer innholdet som en streng
        end
      end,
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = "cmd:pass Claude/OAuth/token",
              },
            })
          end,
        },
        http = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://localhost:22434",
                api_key = "cmd:pass NHN/chat/API-KEY",
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer ${api_key}",
              },
              parameters = {
                sync = true,
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = { name = "ollama", model = "nhn-large:latest" },
        },
        inline = {
          adapter = { name = "ollama", model = "nhn-coder-autocomplete:latest" },
        },
        cmd = {
          adapter = { name = "ollama", model = "nhn-large:latest" },
        },
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "nvim-mini/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}

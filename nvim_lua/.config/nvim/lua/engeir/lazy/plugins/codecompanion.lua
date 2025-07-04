return {
  "olimorris/codecompanion.nvim",
  -- opts = {
  --   strategies = {
  --     --NOTE: Change the adapter as required
  --     chat = { adapter = "ollama" },
  --     inline = { adapter = "ollama" },
  --   },
  -- },
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
      strategies = {
        chat = {
          adapter = { name = "ollama", model = "nhn-small:latest" },
        },
        inline = {
          adapter = { name = "ollama", model = "nhn-code-autocomplete:latest" },
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
      "echasnovski/mini.diff",
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
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "codecompanion" },
      },
      ft = { "codecompanion" },
    },
  },
}

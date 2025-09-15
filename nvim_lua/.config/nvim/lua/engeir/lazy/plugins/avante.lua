return {
  "yetone/avante.nvim",
  enabled = function()
    vim.fn.system("timeout 0.4 ollama list >/dev/null 2>&1")
    return vim.v.shell_error == 0
  end,
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    auto_suggestion_provider = "ollama",
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = false,
      auto_apply_diff_after_generation = true,
      jump_result_buffer_on_finish = false,
      support_paste_from_clipboard = true,
    },
    hints = { enable = true },
    provider = "ollama",
    providers = {
      ollama = {
        endpoint = "http://localhost:22434", -- Note that there is no /v1 at the end.
        -- model = "nhn-thinking-medium:latest",
        -- model = "gemma3:27b-it-q8_0",
        model = "nhn-medium:latest",
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
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

local function getWords()
  return tostring(vim.fn.wordcount().words) .. " words"
end
local function getLines()
  return tostring(vim.api.nvim_buf_line_count(0)) .. " lines"
end
local function get_entr_compiler_status()
  local handle = io.popen('ps aux | grep -i "[e]ntr.*compiler"')
  if handle == nil then
    return ""
  end
  local result = string.match(handle:read("*a"), "compiler .*")
  if result == nil then
    return ""
  end
  local file = vim.fn.expand("%")
  handle:close()
  if string.find(result, file, nil, true) then
    return ", live compiler is ON"
  else
    return ""
  end
end
local function getFileInfo()
  return getWords() .. ", " .. getLines() .. get_entr_compiler_status()
end
local function get_venv()
  local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV") or "NO ENV"
  return " " .. venv
end

return {
  -- Style and colour schemes ===================================================== --
  {
    -- TODO: replace with mini.tabline?
    "akinsho/bufferline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    name = "bufferline",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      { "tiagovla/scope.nvim", config = true },
    },
    keys = {
      { "H", ":BufferLineCyclePrev<CR>", desc = "BufferLine Previous" },
      { "L", ":BufferLineCycleNext<CR>", desc = "BufferLine Next" },
    },
    opts = {
      highlights = {
        tab_separator_selected = {
          bg = "#262626",
        },
        tab_selected = {
          fg = "#ea6962",
          bg = "#262626",
        },
      },
    },
  },
  {
    -- TODO: replace with mini.statusline?
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPre", "BufNewFile" },
    name = "lualine",
    opts = {
      options = {
        icons_enabled = true,
        globalstatus = true,
        component_separators = { "", "" },
        section_separators = { left = "", right = "" },
        -- theme = "gruvbox",
        theme = "auto",
      },
      sections = {
        lualine_c = {
          function()
            return "%="
          end,
          {
            "filename",
            path = 3,
            shorting_target = 80,
          },
          { getFileInfo },
        },
        lualine_y = {
          -- { "swenv", icon = "" },
          -- {
          -- -- https://www.reddit.com/r/neovim/comments/16ya0fr/show_the_current_python_virtual_env_on_statusline/
          --     get_venv,
          --     cond = function()
          --         return vim.bo.filetype == "python"
          --     end,
          -- },
        },
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "toggleterm",
      },
    },
  },
  -- nvim-ts-rainbow is archived, but nvim-ts-rainbow2 is ugly
  { "p00f/nvim-ts-rainbow", event = { "BufReadPre", "BufNewFile" } }, -- Different colour for nested parenthesis
  -- "HiPhish/nvim-ts-rainbow2", -- Different colour for nested parenthesis
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    name = "colorizer",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = {
      keywords = {
        FIXME = {
          icon = " ",
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = { icon = " ", color = "#5888ef" }, -- 'info' is too dark
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = {
          icon = " ",
          color = "#ff9f00",
          alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
        },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        URGE = { icon = "‼ ", color = "#c9ff19", alt = { "IMPORTANT" } },
      },
    },
    keys = {
      { "<leader>tq", "<cmd>TodoQuickFix<CR>", desc = "[T]odo[Q]uickFix" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "[f]ind [T]odoTelescope" },
    },
  },
  { "mechatroner/rainbow_csv", ft = "csv" },
}

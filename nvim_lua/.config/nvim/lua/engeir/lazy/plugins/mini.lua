return {
  -- `mini.nvim`
  -- Replaces:
  --    `junegunn/vim-easy-align     -> mini.align`
  --    `numToStr/Comment.nvim       -> mini.comment`
  --    `RRethy/vim-illuminate       -> mini.cursorword`
  --    `nvim-tree/nvim-web-devicons -> mini.icons`
  --    `windwp/nvim-autopairs       -> mini.pairs      -> altermo/ultimate-autopair.nvim`
  --    `goolord/alpha-nvim          -> mini.starter`
  --    `nvim-lualine/lualine.nvim   -> echasnovski/mini.surround`
  --    `kylechui/nvim-surround      -> mini.surround`
  --    `folke/flash.nvim            -> mini.jump`

  -- `mini.ai` -------------------------------------------------------------------------
  {
    "echasnovski/mini.ai",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- `mini.align` ----------------------------------------------------------------------
  { "echasnovski/mini.align", config = true, event = { "BufReadPre", "BufNewFile" } },

  -- `mini.base16` ---------------------------------------------------------------------
  { "echasnovski/mini.base16", event = { "VeryLazy" }, enabled = false },

  -- `mini.bracketed` ------------------------------------------------------------------
  {
    "echasnovski/mini.bracketed",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<tab>", "<Cmd>lua MiniBracketed.buffer('forward')<CR>", desc = "Buffer Next" },
      {
        "<S-tab>",
        "<Cmd>lua MiniBracketed.buffer('backward')<CR>",
        desc = "Buffer Prev",
      },
      { "]c", "<Cmd>lua MiniBracketed.comment('forward')<CR>", desc = "Comment Next" },
      { "]C", "<Cmd>lua MiniBracketed.comment('backward')<CR>", desc = "Comment Prev" },
      {
        "]x",
        "<Cmd>lua MiniBracketed.conflict('forward')<CR>",
        desc = "Conflict Next",
      },
      {
        "]X",
        "<Cmd>lua MiniBracketed.conflict('backward')<CR>",
        desc = "Conflict Prev",
      },
      {
        "]d",
        function()
          vim.diagnostic.goto_next()
          vim.cmd([[norm zz]])
          vim.diagnostic.open_float()
        end,
      },
      {
        "]D",
        function()
          vim.diagnostic.goto_prev()
          vim.cmd([[norm zz]])
          vim.diagnostic.open_float()
        end,
        { desc = "Diagnostic" },
      },
      { "]f", "<Cmd>lua MiniBracketed.file('forward')<CR>", desc = "File Next" },
      { "]F", "<Cmd>lua MiniBracketed.file('backward')<CR>", desc = "File Prev" },
      { "]i", "<Cmd>lua MiniBracketed.indent('forward')<CR>", desc = "Indent Next" },
      { "]I", "<Cmd>lua MiniBracketed.indent('backward')<CR>", desc = "Indent Prev" },
      { "]j", "<Cmd>lua MiniBracketed.jump('forward')<CR>", desc = "Jump Next" },
      { "]J", "<Cmd>lua MiniBracketed.jump('forward')<CR>", desc = "Jump Prev" },
      {
        "]l",
        "<Cmd>lua MiniBracketed.location('forward')<CR>",
        desc = "Location Next",
      },
      {
        "]L",
        "<Cmd>lua MiniBracketed.location('backward')<CR>",
        desc = "Location Prev",
      },
      { "]o", "<Cmd>lua MiniBracketed.oldfile('forward')<CR>", desc = "Oldfile Next" },
      { "]O", "<Cmd>lua MiniBracketed.oldfile('backward')<CR>", desc = "Oldfile Prev" },
      {
        "]q",
        "<Cmd>lua MiniBracketed.quickfix('forward')<CR>",
        desc = "Quickfix Next",
      },
      {
        "]Q",
        "<Cmd>lua MiniBracketed.quickfix('backward')<CR>",
        desc = "Quickfix Prev",
      },
      {
        "]t",
        "<Cmd>lua MiniBracketed.treesitter('forward')<CR>",
        desc = "Treesitter Next",
      },
      {
        "]T",
        "<Cmd>lua MiniBracketed.treesitter('backward')<CR>",
        desc = "Treesitter Prev",
      },
      { "]u", "<Cmd>lua MiniBracketed.undo('forward')<CR>", desc = "Undo" },
      { "]U", "<Cmd>lua MiniBracketed.undo('backward')<CR>", desc = "Redo" },
      { "]w", "<Cmd>lua MiniBracketed.window('forward')<CR>", desc = "Window Next" },
      { "]W", "<Cmd>lua MiniBracketed.window('backward')<CR>", desc = "Window Prev" },
      { "]y", "<Cmd>lua MiniBracketed.yank('forward')<CR>", desc = "Yank Next" },
      { "]Y", "<Cmd>lua MiniBracketed.yank('backward')<CR>", desc = "Yank Prev" },
    },
    opts = {
      buffer = { suffix = "" },
      comment = { suffix = "" },
      conflict = { suffix = "" },
      diagnostic = { suffix = "" },
      file = { suffix = "" },
      indent = { suffix = "" },
      jump = { suffix = "" },
      location = { suffix = "" },
      oldfile = { suffix = "" },
      quickfix = { suffix = "" },
      treesitter = { suffix = "" },
      undo = { suffix = "" },
      window = { suffix = "" },
      yank = { suffix = "" },
    },
  },

  -- `mini.bufremove` ------------------------------------------------------------------
  {
    "echasnovski/mini.bufremove",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    keys = {
      {
        "<leader>bd",
        function() require("mini.bufremove").delete() end,
        desc = "Buffer Delete",
      },
    },
  },

  -- `mini.clue` -----------------------------------------------------------------------
  {
    "echasnovski/mini.clue",
    enabled = false,
    config = function()
      local miniclue = require("mini.clue")
      miniclue.setup({

        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
          -- Built-in completion
          { mode = "i", keys = "<C-x>" },
          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },
          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },
          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },
          -- Window commands
          { mode = "n", keys = "<C-w>" },
          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
          -- Jumping stuff
          { mode = "n", keys = "]" },
          { mode = "n", keys = "[" },
        },
        clues = {
          -- Enhance this by adding descriptions for `<Leader>` mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows({ submode_resize = true }),
          miniclue.gen_clues.z(),
          { mode = "n", keys = "]b", postkeys = "]" },
          { mode = "n", keys = "[b", postkeys = "[" },
          { mode = "n", keys = "[c", postkeys = "[" },
          { mode = "n", keys = "]c", postkeys = "]" },
          { mode = "n", keys = "[d", postkeys = "[" },
          { mode = "n", keys = "]d", postkeys = "]" },
          { mode = "n", keys = "[h", postkeys = "[" },
          { mode = "n", keys = "]h", postkeys = "]" },
          { mode = "n", keys = "[m", postkeys = "[" },
          { mode = "n", keys = "]m", postkeys = "]" },
          { mode = "n", keys = "[M", postkeys = "[" },
          { mode = "n", keys = "]M", postkeys = "]" },
          { mode = "n", keys = "[n", postkeys = "[" },
          { mode = "n", keys = "]n", postkeys = "]" },
          { mode = "n", keys = "[o", postkeys = "[" },
          { mode = "n", keys = "]o", postkeys = "]" },
          { mode = "n", keys = "[q", postkeys = "[" },
          { mode = "n", keys = "]q", postkeys = "]" },
          { mode = "n", keys = "[s", postkeys = "[" },
          { mode = "n", keys = "]s", postkeys = "]" },
          { mode = "n", keys = "[t", postkeys = "[" },
          { mode = "n", keys = "]t", postkeys = "]" },
          { mode = "n", keys = "[u", postkeys = "[" },
          { mode = "n", keys = "]u", postkeys = "]" },
          { mode = "n", keys = "]w", postkeys = "]" },
          { mode = "n", keys = "[w", postkeys = "[" },
        },
      })
    end,
  },
  -- `mini.colors` ---------------------------------------------------------------------
  {
    "echasnovski/mini.colors",
    version = "*",
    config = true,
    event = { "VeryLazy" },
    enabled = false,
  },

  -- `mini.comment` --------------------------------------------------------------------
  {
    "echasnovski/mini.comment",
    enabled = false,
    version = "*",
    event = "VeryLazy",
    init = function()
      --- Set the comment rule for a file type
      ---@param pattern string
      ---@param c_string string
      local function set_comment(pattern, c_string)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = pattern,
          callback = function() vim.opt_local.commentstring = c_string end,
        })
      end

      set_comment("jsonc", "//%s")
      set_comment("mplstyle", "#%s")
      set_comment("ncl", ";%s")
      set_comment("nu", "#%s")
      set_comment("sent", "#%s")
      set_comment("kdl", "#%s")
    end,
    config = true,
  },

  -- `mini.cursorword` -----------------------------------------------------------------
  {
    "echasnovski/mini.cursorword",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  -- `mini.files` ----------------------------------------------------------------------
  {
    "echasnovski/mini.files",
    config = function()
      require("mini.files").setup({
        content = {
          filter = function(file)
            if vim.endswith(file.name, ".pyi") then
              return false
            else
              return true
            end
          end,
        },
      })
    end,
    keys = {
      {
        "-",
        function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end,
        desc = "[P]ath explorer with [M]iniFiles",
      },
    },
  },

  -- `mini.fuzzy` ----------------------------------------------------------------------
  -- Replaces one of the sorters:
  -- https://github.com/nvim-telescope/telescope.nvim#sorters
  { "echasnovski/mini.fuzzy", config = true },

  -- `mini.hues` -----------------------------------------------------------------------
  {
    "echasnovski/mini.hues",
    enabled = false,
    opts = { background = "#002734", foreground = "#c0c8cc", saturation = "low" },
  },

  -- `mini.icons` ----------------------------------------------------------------------
  { "echasnovski/mini.icons" },

  -- `mini.indentscope` ----------------------------------------------------------------
  {
    "echasnovski/mini.indentscope",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },

  -- `mini.jump` -----------------------------------------------------------------------
  { "echasnovski/mini.jump", version = false, opts = {} },

  -- `mini.operators` ------------------------------------------------------------------
  {
    "echasnovski/mini.operators",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      evaluate = { prefix = "gw=" },
      exchange = { prefix = "gwx" },
      multiply = { prefix = "gwm" },
      replace = { prefix = "gwr" },
      sort = { prefix = "gws" },
    },
  },

  -- `mini.pairs` ----------------------------------------------------------------------
  {
    "echasnovski/mini.pairs",
    enabled = false,
    event = { "InsertEnter", "CmdlineEnter" },
    config = true,
  },

  -- `mini.splitjoin` ------------------------------------------------------------------
  { "echasnovski/mini.splitjoin", config = true, enabled = false },

  -- `mini.statusline`
  {
    "echasnovski/mini.statusline",
    config = function()
      local statuslne = require("mini.statusline")
      statuslne.setup()

      statuslne.section_mode = function()
        local CTRL_S = vim.api.nvim_replace_termcodes("<C-S>", true, true, true)
        local CTRL_V = vim.api.nvim_replace_termcodes("<C-V>", true, true, true)
        local H = {}
        H.modes = setmetatable({
          ["n"] = { long = "Normal", short = "N", hl = "MiniStatuslineModeNormal" },
          ["v"] = { long = "Visual", short = "V", hl = "MiniStatuslineModeVisual" },
          ["V"] = { long = "V-Line", short = "V-L", hl = "MiniStatuslineModeVisual" },
          [CTRL_V] = {
            long = "V-Block",
            short = "V-B",
            hl = "MiniStatuslineModeVisual",
          },
          ["s"] = { long = "Select", short = "S", hl = "MiniStatuslineModeSelect" },
          ["S"] = { long = "S-Line", short = "S-L", hl = "MiniStatuslineModeSelect" },
          [CTRL_S] = {
            long = "S-Block",
            short = "S-B",
            hl = "MiniStatuslineModeSelect",
          },
          ["i"] = { long = "Insert", short = "I", hl = "MiniStatuslineModeInsert" },
          ["R"] = { long = "Replace", short = "R", hl = "MiniStatuslineModeReplace" },
          ["c"] = { long = "Command", short = "C", hl = "MiniStatuslineModeCommand" },
          ["r"] = { long = "Normal", short = "N", hl = "MiniStatuslineModeOther" },
          ["!"] = { long = "Shell", short = "Sh", hl = "MiniStatuslineModeOther" },
          ["t"] = { long = "Terminal", short = "T", hl = "MiniStatuslineModeOther" },
        }, {
          __index = function()
            return { long = "Unknown", short = "U", hl = "%#MiniStatuslineModeOther#" }
          end,
        })
        local mode_info = H.modes[vim.fn.mode()]
        return mode_info.short, mode_info.hl
      end
      ---@diagnostic ldisable-next-line: aduplicate-set-field
      statuslne.section_location = function() return "%2l:%-2v %P" end
    end,
  },

  -- `mini.surround` -------------------------------------------------------------------
  {
    "echasnovski/mini.surround",
    config = true,
    event = { "BufReadPre", "BufNewFile" },
  },

  -- `mini.starter` --------------------------------------------------------------------
  {
    "echasnovski/mini.starter",
    lazy = false,
    config = function()
      local starter = require("mini.starter")
      local function footer()
        -- NOTE: requires the fortune-mod package to work
        -- local handle = io.popen("fortune")
        -- local fortune = handle:read("*a")
        -- handle:close()
        -- return fortune
        local handle = nil
        -- local handle = io.popen("nvim --version")
        if handle == nil then return "Nvim Config by @engeir" end
        local result = "Config by @engeir — "
          .. string.match(handle:read("*a"), "NVIM v[^\n]*")
        handle:close()
        return result
      end

      local my_telescope = {
        {
          name = "All files",
          action = "lua require('telescope.builtin').find_files({hidden=true})",
          section = "Telescope",
        },
        {
          name = "Git files",
          action = "lua require'engeir.lazy.telescope.telescope-extra'.project_files()",
          section = "Telescope",
        },
        {
          name = "Old files",
          action = "Telescope oldfiles",
          section = "Telescope",
        },
        {
          name = "Live grep",
          action = "lua require('telescope.builtin').grep_string({search=''})",
          section = "Telescope",
        },
        {
          name = "Command history",
          action = "Telescope command_history",
          section = "Telescope",
        },
        {
          name = "Help tags",
          action = "Telescope help_tags",
          section = "Telescope",
        },
      }
      local items = {
        my_telescope,
        starter.sections.recent_files(5, true, true),
        starter.sections.recent_files(5, false, true),
        {
          name = "Open TODO",
          action = ":e ~/Documents/notes_papers/_includes/todo.md",
          section = "Builtin actions",
        },
        starter.sections.builtin_actions(),
      }
      local content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.indexing("all", { "Builtin actions", "Telescope" }),
        starter.gen_hook.aligning("center", "center"),
      }
      local starter_opts = {
        items = items,
        content_hooks = content_hooks,
        header = [[
                              ██╗
                            ██╔═██╗
                  ██████╗   ██║ ██║ ██╗
                  ╚═════╝   ╚═██╔═╝ ██║
                ██████╗   ██████████╔═╝
                ╚═════╝   ██╔═██╔═══╝
                ██████╗   ██║ ██║
                ╚═════╝   ╚═╝ ██║
                ██████╗ ████╗ ██████╗
                ╚═════╝ ╚═██║ ██║ ██║
                  ██████╗ ██████║ ██║
                  ╚═════╝ ╚═════╝ ████╗
                                  ╚═══╝
            ]],
        footer = footer(),
      }
      starter.setup(starter_opts)
    end,
  },

  -- `mini.tabline`
  {
    "echasnovski/mini.tabline",
    opts = {
      tabpage_section = "right",
      format = function(buf_id, label)
        local suffix = vim.bo[buf_id].modified and "+ " or ""
        ---@diagnostic disable-next-line: undefined-global
        return MiniTabline.default_format(buf_id, label) .. suffix
      end,
    },
    -- Next and previous buffer is controlled with `mini.bracketed`.
  },

  -- `mini.trailspace` -----------------------------------------------------------------
  {
    "echasnovski/mini.trailspace",
    enabled = false,
    init = function() require("mini.trailspace").setup() end,
    keys = {
      {
        "<leader>mt",
        function()
          require("mini.trailspace").trim()
          require("mini.trailspace").trim_last_lines()
        end,
        desc = "[M]iniTrailspace [T]rim",
      },
    },
  },
}

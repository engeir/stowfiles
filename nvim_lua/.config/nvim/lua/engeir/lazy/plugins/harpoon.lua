return {
  "ThePrimeagen/harpoon",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>hf",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon Find",
    },
    {
      "<leader>hm",
      function()
        local harpoon = require("harpoon")
        harpoon:list():add()
      end,
      desc = "Harpoon Mark",
    },
    {
      "<leader>hn",
      function()
        local harpoon = require("harpoon")
        local HarpoonList = harpoon:list()
        function HarpoonList:next()
          self._index = self._index + 1
          if self._index > #self.items then self._index = 1 end

          self:select(self._index)
        end
        HarpoonList:next()
      end,
      desc = "Harpoon Next",
    },
    {
      "<leader>hN",
      function()
        local harpoon = require("harpoon")
        local HarpoonList = harpoon:list()
        function HarpoonList:prev()
          self._index = self._index - 1
          if self._index < 1 then self._index = #self.items end

          self:select(self._index)
        end
        HarpoonList:prev()
      end,
      desc = "Harpoon previous",
    },
    {
      "<leader>1",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(1)
      end,
      desc = "Harpoon first",
    },
    {
      "<leader>2",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(2)
      end,
      desc = "Harpoon second",
    },
    {
      "<leader>3",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(3)
      end,
      desc = "Harpoon third",
    },
    {
      "<leader>4",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(4)
      end,
      desc = "Harpoon fourth",
    },
  },
  config = function()
    local opts = {
      settings = { save_on_toggle = true },
      menu = {
        width = math.floor(vim.api.nvim_win_get_width(0) * 0.5),
      },
    }
    local harpoon = require("harpoon")
    harpoon:setup(opts)
  end,
}

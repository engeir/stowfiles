return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  enabled = IS_KNOWN,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local opts = {
      settings = { save_on_toggle = true },
      menu = {
        width = math.floor(vim.api.nvim_win_get_width(0) * 0.5),
      },
    }
    local harpoon = require("harpoon")
    harpoon:setup(opts)
    vim.keymap.set("n", "<leader>hm", function()
      harpoon:list():append()
    end)
    vim.keymap.set("n", "<leader>hf", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    local HarpoonList = harpoon:list()
    function HarpoonList:next()
      self._index = self._index + 1
      if self._index > #self.items then
        self._index = 1
      end

      self:select(self._index)
    end

    function HarpoonList:prev()
      self._index = self._index - 1
      if self._index < 1 then
        self._index = #self.items
      end

      self:select(self._index)
    end
    vim.keymap.set("n", "<leader>hn", function()
      HarpoonList:next()
    end)
    vim.keymap.set("n", "<leader>hN", function()
      HarpoonList:prev()
    end)
    vim.keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end)
  end,
}

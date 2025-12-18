return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    ext = "svg",
  },
  keys = {
    {
      "<leader>fi",
      function()
        Snacks.picker.files({
          ft = { "jpg", "jpeg", "png", "webp" },
          confirm = function(self, item, _)
            self:close()
            require("img-clip").paste_image({}, "./" .. item.file) -- ./ is necessary for img-clip to recognize it as path
          end,
        })
      end,
      desc = "Find images to paste in (Snacks).",
    },
  },
}

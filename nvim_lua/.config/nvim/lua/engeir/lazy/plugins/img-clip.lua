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
        local ok, telescope = pcall(require, "telescope.builtin")
        if not ok then return end
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        telescope.find_files({
          find_command = { "fd", "-e", "png", "-e", "jpg", "-e", "svg", "-e", "pdf" },
          attach_mappings = function(_, map)
            local function embed_image(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              local filepath = entry[1]
              actions.close(prompt_bufnr)

              local img_clip = require("img-clip")
              img_clip.paste_image(nil, filepath)
            end

            map("i", "<CR>", embed_image)
            map("n", "<CR>", embed_image)

            return true
          end,
        })
      end,
      desc = "Find images to paste in.",
    },
  },
}

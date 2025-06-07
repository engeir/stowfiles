return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "ObsidianQuickSwitch" }, -- "ObsidianWorkspace"
  keys = {
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>" },
    { "<leader>on", "<cmd>ObsidianNew<CR>" },
  },
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/.local/share/obsidian-vault/Work/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/.local/share/obsidian-vault/Work/**.md",
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "/projects/simple-recipes-cookbook/src/**.md",
    "BufNewFile "
      .. vim.fn.expand("~")
      .. "/projects/simple-recipes-cookbook/src/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = { enable = false },
    workspaces = {
      {
        name = "work",
        path = "~/.local/share/obsidian-vault/Work",
      },
      {
        name = "mere",
        path = "~/projects/simple-recipes-cookbook/src",
      },
    },
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = false,
      -- Enables completion using blink.cmp
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
      -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.date("%Y-%m-%dT%H-%M-%S")) .. "-" .. suffix
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.title)
      return path:with_suffix(".md")
    end,
  },
}

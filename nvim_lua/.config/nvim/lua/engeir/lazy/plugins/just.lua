return {
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
  {
    {
      "al1-ce/just.nvim",
      ft = { "just" },
      cmd = {
        "JustDefault", -- Builds current file/project using default task.
        "JustBuild", -- Builds current file/project using build task.
        "JustRun", -- Builds current file/project using run task.
        "JustTest", -- Builds current file/project using test task.
        "JustSelect", -- Gives you selection of all tasks in justdfile.
        "JustStop", -- Stops currently executed task
        "JustCreateTemplate", -- Creates template justdfile with included "cheatsheet".
      },
      keys = {
        { "<leader>jd", "<cmd>JustDefault<cr>", desc = "[J]ust[D]efault" },
        { "<leader>jb", "<cmd>JustBuild<cr>", desc = "[J]ust[B]uild" },
        { "<leader>jr", "<cmd>JustRun<cr>", desc = "[J]ust[R]un" },
        { "<leader>jt", "<cmd>JustTest<cr>", desc = "[J]ust[T]est" },
        { "<leader>js", "<cmd>JustSelect<cr>", desc = "[J]ust[S]elect" },
        { "<leader>jk", "<cmd>JustStop<cr>", desc = "[J]ust[K]ill" },
        { "<leader>jc", "<cmd>JustCreateTemplate<cr>", desc = "[J]ust[C]reate" },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "rcarriga/nvim-notify",
        "j-hui/fidget.nvim",
      },
      config = true,
    },
  },
}

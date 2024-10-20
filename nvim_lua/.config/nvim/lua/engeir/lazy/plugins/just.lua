return {
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
  {
    {
      "al1-ce/just.nvim",
      enabled = false,
      ft = { "just" },
      -- An update seem to be in the works, where a more general `runme` command is used.
      -- commit = "c32dc02",
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
        { "<leader>jd", "<cmd>JustDefault<cr>", desc = "Just: Default" },
        { "<leader>jb", "<cmd>JustBuild<cr>", desc = "Just: Build" },
        { "<leader>jr", "<cmd>JustRun<cr>", desc = "Just: Run" },
        { "<leader>jt", "<cmd>JustTest<cr>", desc = "Just: Test" },
        { "<leader>js", "<cmd>JustSelect<cr>", desc = "Just: Select" },
        { "<leader>jk", "<cmd>JustStop<cr>", desc = "Just: Kill" },
        { "<leader>jc", "<cmd>JustCreateTemplate<cr>", desc = "Just: Create" },
      },
      dependencies = {
        "nvim-lua/plenary.nvim", -- async jobs
        "nvim-telescope/telescope.nvim", -- task picker
        "rcarriga/nvim-notify", -- general notifications (optional)
        "j-hui/fidget.nvim", -- task progress
        "al1-ce/jsfunc.nvim", -- extension library
      },
      config = true,
    },
  },
}

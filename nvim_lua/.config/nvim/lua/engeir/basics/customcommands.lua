vim.api.nvim_create_user_command(
  "RevealJSRefList",
  "!sh ~/bin/revealjs-make-reflist %",
  {}
)

vim.api.nvim_create_user_command(
  "FlameshotSvg",
  "!mkdir -p %:p:h/svg/ && flameshot gui -p %:p:h/svg/",
  { desc = "Create a screenshot with Flameshot and place it in an svg directory" }
)

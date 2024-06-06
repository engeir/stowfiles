vim.bo.commentstring = "; %s"
local homedir = vim.loop.os_homedir()
if homedir == "/home/een023" then
  vim.cmd("source $HOME/.config/nvim/other-resources/add_ncl_complete_to_your_vimrc")
elseif homedir == "/cluster/home/een023" then
  vim.cmd("source $HOME/.config/nvim/other-resources/add_ncl_complete_to_your_vimrc")
end

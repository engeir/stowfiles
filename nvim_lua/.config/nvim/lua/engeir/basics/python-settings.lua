-- Set up python provider
-- Create a venv and install pynvim, i.e.
-- python -m pip install --user --upgrade pynvim
-- Finally we set it as the python3_host_prog:
-- Probably need to use uname -o
local homedir = vim.loop.os_homedir()

if
  homedir == "/home/een023"
  or homedir == "/home/eirikre"
  or homedir == "/home/eirik"
then
  vim.g.python3_host_prog = vim.fn.expand("$HOME/.local/share/nvim/.venv/bin/python")
  -- vim.cmd("source $HOME/.config/nvim/other-resources/add_ncl_complete_to_your_vimrc")
elseif homedir == "/cluster/home/een023" then
  vim.g.python3_host_prog =
    vim.fn.expand("/cluster/software/Python/3.10.8-GCCcore-12.2.0/bin/python3")
  -- vim.cmd("source $HOME/.config/nvim/other-resources/add_ncl_complete_to_your_vimrc")
elseif vim.fn.has("macunix") == 1 then
  vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/py3nvim/bin/python")
end

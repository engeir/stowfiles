-- Set up python provider
-- Create a venv and install pynvim, i.e.
-- python -m pip install --user --upgrade pynvim
-- Finally we set it as the python3_host_prog:
-- Probably need to use uname -o
local os = vim.fn.systemlist("uname -s")
local os2 = vim.fn.systemlist("uname -n")
if os[1] == "Linux" then
    if os2[1] == "ubuntu-work" then
        vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/py3nvim/bin/python")
        vim.cmd("source $HOME/.config/cdo/add_cdo_complete_to_your_vimrc")
    elseif string.find(os2[1], "fram.sigma2.no") then
        vim.g.python3_host_prog = vim.fn.expand("$HOME/Envs/py3nvim/bin/python")
        vim.cmd("source $HOME/.config/cdo/add_cdo_complete_to_your_vimrc")
    end
elseif os[1] == "Darwin" then
    vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/py3nvim/bin/python")
end
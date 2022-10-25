local ok, swenv = pcall(require, "swenv")
if not ok then
    return
end

if IS_KNOWN then
    swenv.setup({
        -- Should return a list of tables with a `name` and a `path` entry each.
        -- Gets the argument `venvs_path` set below.
        -- By default just lists the entries in `venvs_path`.
        get_venvs = function(venvs_path)
            return require("swenv.api").get_venvs(venvs_path)
        end,
        -- Path passed to `get_venvs`.
        venvs_path = vim.fn.expand("~/.pyenv/versions/"),
        -- Something to do after setting an environment
        post_set_venv = nil,
    })
end

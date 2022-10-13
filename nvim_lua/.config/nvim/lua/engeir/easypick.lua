local ok, easypick = pcall(require, "easypick")
if not ok then
    return
end

-- only required for the example to work
local base_branch = "develop"
-- a list of commands that you want to pick from
local list = [[
<< EOF
:PackerInstall
:Telescope find_files
:Git blame
EOF
]]
easypick.setup({
    pickers = {
        -- add your custom pickers here
        -- below you can find some examples of what those can look like

        {
            name = "nobin",
            command = 'git grep --cached -Il ""',
            previewer = easypick.previewers.default(),
        },
        {
            name = "command_palette",
            command = "cat " .. list,
            -- pass a pre-configured action that runs the command
            action = easypick.actions.run_nvim_command,
            -- you can specify any theme you want, but the dropdown looks good for this example =)
            opts = require("telescope.themes").get_dropdown({}),
        },

        -- diff current branch with base_branch and show files that changed with respective diffs in preview
        {
            name = "changed_files",
            command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
            previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
        },

        -- list files that have conflicts with diffs in preview
        {
            name = "conflicts",
            command = "git diff --name-only --diff-filter=U --relative",
            previewer = easypick.previewers.file_diff(),
        },
    },
})

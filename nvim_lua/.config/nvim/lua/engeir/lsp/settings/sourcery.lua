local executable = function(x)
    return vim.fn.executable(x) == 1
end
if not executable("pass") then
    return
end
return {
    init_options = {
        token = io.popen("pass Sourcery/token", "r"):read("l"),
    },
}

-- Pretty print of tables
P = function(v)
    print(vim.inspect(v))
    return v
end

PLUGINS = function ()
    for key, value in pairs(packer_plugins) do
        print(key)
        -- print(value.loaded)
    end
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

-- Check if the computer is one I recognise, if no, do not install copilot and
-- grammar-guard
IS_KNOWN = (function()
    local output = vim.fn.systemlist("uname -n")
    local known = { "ubuntu-work", "eenMBP.local" }
    for _, v in ipairs(known) do
        if v == output[1] then
            return true
        end
    end
    return false
end)()
EXECUTABLE = function(x)
    return vim.fn.executable(x) == 1
end
HAS = function(x)
    return vim.fn.has(x) == 1
end
IS_WSL = (function()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end)()
IS_MAC = HAS("macunix")
IS_LINUX = not IS_WSL and not IS_MAC

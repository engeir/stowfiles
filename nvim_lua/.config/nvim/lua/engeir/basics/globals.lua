-- Pretty print of tables
P = function(v)
  print(vim.inspect(v))
  return v
end

LAZY_PLUGINS = function()
  for _, value in pairs(require("lazy").plugins()) do
    print("- [" .. value.name .. "](" .. value.url .. ")")
  end
end
PACKER_PLUGINS = function()
  for key, value in pairs(packer_plugins) do
    print("[" .. key .. "](" .. value.url .. ")")
  end
end

RELOAD = function(...) return require("plenary.reload").reload_module(...) end

R = function(name)
  RELOAD(name)
  return require(name)
end

local path_engb = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
local words_engb = {}
for word in io.open(path_engb, "r"):lines() do
    table.insert(words_engb, word)
end
return {
    settings = {
        ltex = {
            language = "en-GB",
            dictionary = {
                ["en"] = words_engb,
                ["en-GB"] = words_engb,
                ["no"] = {},
            },
        },
    },
}

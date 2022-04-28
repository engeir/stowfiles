using JSON

function convert_snip(snippet::Vector{String})
    prefix = split(snippet[1], " ")[2]
    body = replace.(snippet[2:end-1], "\\\\" => "\\")
    json_snip = Dict(
            "prefix" => prefix,
            "body" => body,
        )
    return json_snip
end

function convert_snipfile(file::String)
    contents = readlines(file)
    start_end_indices = zip(
        findall(x -> x ==  1, startswith.(contents, "snippet")),
        findall(x -> x ==  1, startswith.(contents, "endsnippet"))
    )
    converted_snippets = [contents[starts:ends] for (starts, ends) in start_end_indices]

    json_snips = Dict()
    for snippet in converted_snippets
        occursin("!p", snippet[2]) && continue # exclude python snippets
        !occursin("\"", snippet[1]) && continue
        name = replace(match(r"\\\"(.*)\\\"", snippet[1]).match, "\"" => "")
        json_snips[name] = convert_snip(snippet)
    end

    filename = replace(file, ".snippets" => "")
    open("$filename.json", "w") do io
        JSON.print(io, json_snips, 4)
    end
end

convert_snipfile.(ARGS)

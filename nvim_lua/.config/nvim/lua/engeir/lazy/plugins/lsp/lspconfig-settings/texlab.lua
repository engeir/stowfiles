local util = require("lspconfig.util")

local function buf_clean(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local texlab_client = util.get_active_client_by_name(bufnr, "texlab")
  local params = {
    command = "texlab.cleanArtifacts",
    arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
  }
  if texlab_client then
    texlab_client.request("workspace/executeCommand", params, function(err, _)
      if err then
        error(tostring(err))
      end
    end, bufnr)
  else
    print(
      "method workspace/executeCommand is not supported by any servers active on the current buffer"
    )
  end
end

local function buf_show_dep_graph(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local texlab_client = util.get_active_client_by_name(bufnr, "texlab")
  local params = {
    command = "texlab.showDependencyGraph",
    -- arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
  }
  if texlab_client then
    texlab_client.request("workspace/executeCommand", params, function(err, result)
      if err then
        error(tostring(err))
      end
      print(result.status)
    end, bufnr)
  else
    print(
      "method workspace/executeCommand is not supported by any servers active on the current buffer"
    )
  end
end

return {
  -- https://github.com/latex-lsp/texlab/wiki/Configuration
  settings = {
    texlab = {
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
      experimental = {
        followPackageLinks = true,
        citationCommands = {
          "citeA",
        },
        labelReferenceCommands = {
          "subref",
        },
        mathEnvironments = {
          "align*",
          "equation",
        },
      },
      formatterLineLength = -1, -- bib files
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
      latexindent = { modifyLineBreaks = true },
      build = {
        onSave = true,
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
        },
      },
    },
  },
  commands = {
    TexlabClean = {
      function()
        buf_clean(0)
      end,
      description = "Clean the texlab artifacts",
    },
    TexlabShowDepGraph = {
      function()
        buf_show_dep_graph(0)
      end,
      description = "Show the texlab dependency graph",
    },
  },
  on_attach = function(_, bufnr)
    -- Set up keymap that forward searches
    vim.keymap.set(
      "n",
      "<localleader>tv",
      "<cmd>TexlabForward<CR>",
      { buffer = bufnr, desc = "Texlab forward search doc" }
    )
    vim.keymap.set(
      "n",
      "<localleader>tb",
      "<cmd>TexlabBuild<CR>",
      { buffer = bufnr, desc = "Texlab build doc" }
    )
  end,
}

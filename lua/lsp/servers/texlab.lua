local M = {}

M.settings = {
  texlab = {
    exec = "texlab",
    options = {
      capabilities = {
        textDocument = {
          completion = {
            completionItem = { snippetSupport = true },
          },
        },
      },
      settings = {
        bibtex = {
          formatting = {
            lineLength = 120,
          },
        },
        latex = {
          forwardSearch = {
            args = {},
            onSave = false,
          },
          build = {
            args = {
              "-outdir=texlab",
              "-pdf",
              "-interaction=nonstopmode",
              "-synctex=1",
              "%f",
            },
            executable = "latexmk",
            onSave = true,
          },
          lint = {
            onChange = true,
          },
        },
      },
    },
  },
}

return M

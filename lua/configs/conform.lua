local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "black" },
    tex = { "latexindent" },
    javascript = { "prettier" },
    typescript = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
    async = false
  },
  formatters = {
    isort = {
      command = "isort",
      args = {
        "-",
      },
    },
  },
  notify_on_error = true
}

return options

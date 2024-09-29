local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "black" },
    tex = { "latexindent" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    cpp = { "clang_format" },
  },
  timeout_ms = 5000,
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
    async = false,
  },
  formatters = {
    clang_format = {
      command = "clang-format",
      prepend_args = { "--style={BasedOnStyle: llvm, IndentWidth: 4}" },
    },
  },
  notify_on_error = true,
}

return options

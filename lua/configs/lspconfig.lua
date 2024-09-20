-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "texlab", "tsserver", "jsonls", "eslint", "tailwindcss", "lua_ls", "sqlls" }
local nvlsp = require "nvchad.configs.lspconfig"

local function on_attach(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  end
  nvlsp.on_attach(client, bufnr)
end

local capabilities = nvlsp.capabilities
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end

-- python (basedpyright)
local function set_basedpyright_type_checking_mode(mode, init)
  -- exit if the server is already running
  if init then
    for _, client in pairs(vim.lsp.get_active_clients()) do
      if client.name == "basedpyright" then
        local config = client.config
        config.settings.basedpyright.typeCheckingMode = mode
        local resp = client.notify("workspace/didChangeConfiguration", {})

        if not resp then
          print("Failed to set basedpyright typeCheckingMode to " .. mode)
        else
          print("Changed basedpyright typeCheckingMode to " .. mode)
        end

        return
      end
    end
  end

  lspconfig.basedpyright.setup {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
    settings = {
      basedpyright = {
        typeCheckingMode = mode,
      },
    },
  }
end

set_basedpyright_type_checking_mode("standard", true)

-- keymaps for changing basedpyright typeCheckingMode
vim.keymap.set("n", "<leader>po", function()
  set_basedpyright_type_checking_mode("off", false)
end, { desc = "Set basedpyright typeCheckingMode to off" })

vim.keymap.set("n", "<leader>pb", function()
  set_basedpyright_type_checking_mode("basic", true)
end, { desc = "Set basedpyright typeCheckingMode to basic" })

vim.keymap.set("n", "<leader>pd", function()
  set_basedpyright_type_checking_mode("standard", true)
end, { desc = "Set basedpyright typeCheckingMode to standard" })

vim.keymap.set("n", "<leader>ps", function()
  set_basedpyright_type_checking_mode("strict", true)
end, { desc = "Set basedpyright typeCheckingMode to strict" })

vim.keymap.set("n", "<leader>pa", function()
  set_basedpyright_type_checking_mode("all", true)
end, { desc = "Set basedpyright typeCheckingMode to all" })

-- lsp for cpp (clangd)

lspconfig.clangd.setup {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--enable-config",
    "--header-insertion=never",
    "--query-driver=C:/src/msys64/ucrt64/bin/g++.exe",
    "--compile-commands-dir=build",
    "--clang-tidy",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git"
  ),
  init_options = {
    compilationDatabasePath = ".",
  },
}

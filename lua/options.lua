require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.env.PATH = vim.env.PATH .. ":/usr/local/bin/yazi"
vim.env.YAZI_CONFIG_HOME="/mnt/d/Productivity/Projects/dev-setup/yazi"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true -- if you want spaces instead of tabs
vim.opt.relativenumber = true
vim.opt.number = true

-- nvim ufo
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd "checktime"
    end
  end,
})

local indent_settings = {
  default = 4,
  overrides = {
    javascript = 2,
    typescript = 2,
    yaml = 2,
    json = 2,
    html = 2,
    css = 2,
    lua = 2,
  },
}

local function set_indent()
  local filetype = vim.bo.filetype
  local indent = indent_settings.overrides[filetype] or indent_settings.default
  vim.bo.shiftwidth = indent
  vim.bo.tabstop = indent
  vim.bo.softtabstop = indent
  vim.bo.expandtab = true -- Use spaces instead of tabs
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = set_indent,
})

require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept-word)")

map("n", "<leader>i", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- map ctrl + a to select all
map({ "n", "i", "v" }, "<C-a>", "gg0VG$", { noremap = true, silent = true })

-- map ctrl + backspace to delete previous word
map("i", "<C-w>", "<C-\\><C-n>dB", { noremap = true, silent = true })
map("i", "<C-h>", "<C-w>", { noremap = true, silent = true })

-- map ctrl + Alt + h, j, k, l to move in insert mode
map("i", "<C-M-h>", "<Left>", { noremap = true, silent = true })
map("i", "<C-M-j>", "<Down>", { noremap = true, silent = true })
map("i", "<C-M-k>", "<Up>", { noremap = true, silent = true })
map("i", "<C-M-l>", "<Right>", { noremap = true, silent = true })

-- map("n", "<F5>", function()
--   local term = require "nvchad.term"
--   local file = vim.fn.expand "%"
--   local fNoExt = file:gsub("%..*", "")
--
--   local ft_cmds = {
--     python = "python3 " .. file,
--     cpp = "clear && g++ --std=c++17 -DLOCAL -Wall -Wextra -Wshadow -O2 -lm -o "
--       .. fNoExt
--       .. " "
--       .. file
--       .. " && ./"
--       .. fNoExt
--       .. " <in.txt | tee out.txt",
--     -- print(ft_cmds["cpp"])
--   }
--
--   local cmd = ft_cmds[vim.bo.ft]
--
--   if cmd == nil then
--     vim.notify("No command found for filetype: " .. vim.bo.ft, vim.log.levels.WARN)
--     return
--   end
--
--   local opts = {
--     id = "horizontalTerm",
--     pos = "sp",
--     cmd = cmd,
--   }
--   term.runner(opts)
-- end, { desc = "Run code" })

map("n", "<F5>", function()
  local term = require "nvchad.term"
  local file = vim.fn.expand "%"
  local fNoExt = file:gsub("%..*", "")
  local ft_cmds = {
    python = "python3 " .. file,
    cpp = "clear && g++ --std=c++17 -DLOCAL -Wall -Wextra -Wshadow -O2 -lm -o "
      .. fNoExt
      .. " "
      .. file
      .. " && ./"
      .. fNoExt
      .. " <in.txt | tee out.txt",
    java = "clear && javac " .. file .. " && java " .. fNoExt .. " <in.txt | tee out.txt",
  }
  local cmd = ft_cmds[vim.bo.ft]
  if cmd == nil then
    vim.notify("No command found for filetype: " .. vim.bo.ft, vim.log.levels.WARN)
    return
  end

  -- Find the terminal buffer by iterating through nvchad_terms
  local term_buf = nil
  local term_info = nil

  for id, info in pairs(vim.g.nvchad_terms or {}) do
    if info.id == "horizontalTerm" and vim.api.nvim_buf_is_valid(info.buf) then
      term_buf = info.buf
      term_info = info
      break
    end
  end

  -- If we found a valid terminal buffer
  if term_buf then
    local win_id = vim.fn.bufwinid(term_buf)

    -- If terminal window isn't visible, make it visible
    if win_id == -1 then
      vim.cmd "sp" -- Split horizontally
      vim.api.nvim_win_set_buf(0, term_buf)

      -- Apply window options if available
      if term_info.winopts then
        for k, v in pairs(term_info.winopts) do
          vim.wo[0][k] = v
        end
      end
    end

    -- Send command to terminal
    local job_id = vim.b[term_buf].terminal_job_id
    if job_id then
      vim.api.nvim_chan_send(job_id, "clear; " .. cmd .. " \n")
      vim.cmd "startinsert"
    else
      -- Job doesn't exist, create new terminal
      term.new {
        id = "horizontalTerm",
        pos = "sp",
        cmd = cmd,
      }
    end
  else
    -- No existing terminal, create new one
    term.new {
      id = "horizontalTerm",
      pos = "sp",
      cmd = cmd,
    }
  end
end, { desc = "Run code" })
map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

vim.opt.clipboard = "unnamedplus"

vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = true,
}

vim.keymap.set({ "n", "t" }, "<F2>", function()
  require("nvchad.term").toggle { pos = "sp", id = "horizontalTerm" }
end)

vim.keymap.set({ "n", "t" }, "<F3>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "verticalTerm" }
end)

vim.keymap.set({ "n", "t" }, "<F4>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatingTerm" }
end)


vim.keymap.set("n", "<leader>ti", function()
  if vim.opt.shiftwidth:get() == 2 then
    -- Switch to 4-space indentation
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
    print("Switched to 4-space indentation")
  else
    -- Switch to 2-space indentation
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
    print("Switched to 2-space indentation")
  end
end, { desc = "Toggle between 2-space and 4-space indentation" })

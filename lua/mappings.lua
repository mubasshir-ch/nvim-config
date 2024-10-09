require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

vim.keymap.set("i", "<M-j>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<M-l>", "<Plug>(copilot-accept-word)")

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

-- cpp code runner for cp
map("n", "<C-B>", function()
    local file = vim.fn.expand "%:p"
    local ext = vim.fn.expand "%:e"
    if ext == "cpp" then
        vim.cmd(
            "!g++ --std=c++17 -DLOCAL -Wall -Wextra -Wshadow -O2 -lm "
            .. file
            .. " -o "
            .. file:gsub(".cpp", ".exe")
            .. " && "
            .. file:gsub(".cpp", ".exe" .. "<in.txt >out.txt")
        )
    else
        print "Not a valid file to run"
    end
end, { desc = "Run code" })

-- Dismiss Noice Message
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

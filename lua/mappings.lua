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

map("n", "<C-B>", function()
    require("nvchad.term").runner {
        id = "horizontalTerm",
        pos = "sp",

        cmd = function()
            local file = vim.fn.expand "%"
            local fNoExt = file:gsub("%..*", "")

            local ft_cmds = {
                python = "python3 " .. file,
                cpp = "clear && g++ --std=c++17 -DLOCAL -Wall -Wextra -Wshadow -O2 -lm -o " .. fNoExt .. " " ..
                    file .. " && " .. fNoExt .. " <in.txt | tee out.txt",
            }
            -- print(ft_cmds["cpp"])

            return ft_cmds[vim.bo.ft]
        end,
    }
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


vim.keymap.set({ "n", "t" }, "<F2>", function()
    require("nvchad.term").toggle { pos = "sp", id = "horizontalTerm" }
end)

vim.keymap.set({ "n", "t" }, "<F3>", function()
    require("nvchad.term").toggle { pos = "vsp", id = "verticalTerm" }
end)

vim.keymap.set({ "n", "t" }, "<F4>", function()
    require("nvchad.term").toggle { pos = "float", id = "floatingTerm" }
end)

-- Load NvChad's default mappings
require "nvchad.mappings"
local map = vim.keymap.set

-- General mappings
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Git mappings
map("n", "<Leader>gg", ":G<CR>", { desc = "Git status", noremap = true, silent = true })
map("n", "<Leader>gz", ":LazyGit<CR>", { desc = "Open Lazygit", noremap = true, silent = true })

-- Save file with Ctrl+S
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file", noremap = true, silent = true })

-- Load NvChad's default mappings
require "nvchad.mappings"

-- Custom mappings
local map = vim.keymap.set

-- General mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Git
map("n", "<Leader>gg", ":G<CR>", { desc = "Git", noremap = true, silent = true })

-- Save file with Ctrl+S in normal, insert, and visual modes
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file", noremap = true, silent = true })

-- Add gz binding for Lazygit
map("n", "<Leader>gz", ":LazyGit<CR>", { desc = "Open Lazygit", noremap = true, silent = true })

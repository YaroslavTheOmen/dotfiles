-- Load NvChad's default mappings
require "nvchad.mappings"
local map = vim.keymap.set

-- General mappings
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Git mappings
map("n", "<Leader>gg", ":G<CR>", { desc = "Git status", noremap = true, silent = true })
map("n", "<Leader>gz", ":LazyGit<CR>", { desc = "Open Lazygit", noremap = true, silent = true })

-- modern theme picer
map("n", "<leader-th>", function()
  require("nvchad.themes").open {
    icon = "",
    style = "compact", -- optional! compact/flat/bordered
  }
end, { desc = "open theme picker" })

-- minty
map("n", "<Leader>to", function()
  require("minty.huefy").toggle { border = true }
end, { desc = "fancy color picker" })

-- menu
-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next { keywords = { "ERROR", "WARNING" } }
end, { desc = "Next error/warning todo comment" })

-- Save file with Ctrl+S
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file", noremap = true, silent = true })

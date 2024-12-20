-- Load NvChad's default mappings
require("nvchad.mappings")
local map = vim.keymap.set

-- Github
map(
   "n",
   "<Leader>co",
   ":Copilot enable<CR>",
   { desc = " Enable Copilot", noremap = true, silent = true }
)
map(
   "n",
   "<Leader>cf",
   ":Copilot disable<CR>",
   { desc = " Disable Copilot", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("i", "<M-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_no_tab_map = true

-- General mappings
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Git mappings
map("n", "<Leader>gg", ":G<CR>", { desc = " Git status", noremap = true, silent = true })
map(
   "n",
   "<Leader>gz",
   ":FloatermNew LazyGit<CR>",
   { desc = " Open Lazygit", noremap = true, silent = true }
)

-- modern theme picer
map("n", "<leader-th>", function()
   require("nvchad.themes").open({
      icon = "",
      style = "compact", -- optional! compact/flat/bordered
   })
end, { desc = "open theme picker" })

-- minty
map("n", "<Leader>to", function()
   require("minty.huefy").open({ border = true })
end, { desc = " fancy color picker" })

-- menu
-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
   require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
   vim.cmd.exec('"normal! \\<RightMouse>"')

   local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
   require("menu").open(options, { mouse = true })
end, {})

-- Notes Plugin
vim.keymap.set("n", "]t", function()
   require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
   require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords
--vim.keymap.set("n", "]t", function()
--	require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
--end, { desc = "Next error/warning todo comment" })

-- turn of lazygit terminal
vim.api.nvim_create_autocmd("TermOpen", {
   pattern = "term://*lazygit*",
   callback = function()
      vim.api.nvim_buf_set_keymap(0, "t", ":", "<Nop>", { noremap = true, silent = true })
   end,
})

-- floating terminal
map(
   "n",
   "<Leader>tN",
   "<cmd>FloatermNew<CR>",
   { desc = "New floating terminal", noremap = true, silent = true }
)
map(
   "n",
   "<Leader>tt",
   "<cmd>FloatermToggle<CR>",
   { desc = "Toggle floating terminal", noremap = true, silent = true }
)
map(
   "n",
   "<Leader>tk",
   "<cmd>FloatermKill<CR>",
   { desc = "Kill floating terminal", noremap = true, silent = true }
)
map(
   "n",
   "<Leader>tn",
   "<cmd>FloatermNext<CR>",
   { desc = "Next floating terminal", noremap = true, silent = true }
)
map(
   "n",
   "<Leader>tp",
   "<cmd>FloatermPrev<CR>",
   { desc = "Previous floating terminal", noremap = true, silent = true }
)
map(
   "n",
   "<Leader>ta",
   "<cmd>FloatermKill!<CR>",
   { desc = "Kill all floating terminals", noremap = true, silent = true }
)

vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.9
vim.g.floaterm_wintype = "float"
vim.g.floaterm_position = "center"

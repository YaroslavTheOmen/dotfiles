-- Load NvChad's default mappings (if needed)
require("nvchad.mappings")

-- Helper Functions

-- A small helper to define normal-mode maps with common defaults
local function nmap(lhs, rhs, desc, opts)
   local default_opts = { desc = desc, noremap = true, silent = true }
   -- Merge passed-in opts if any
   if opts then
      default_opts = vim.tbl_extend("force", default_opts, opts)
   end
   vim.keymap.set("n", lhs, rhs, default_opts)
end

-- A small helper to define insert-mode maps
local function imap(lhs, rhs, desc, opts)
   local default_opts = { desc = desc, noremap = true, silent = true }
   if opts then
      default_opts = vim.tbl_extend("force", default_opts, opts)
   end
   vim.keymap.set("i", lhs, rhs, default_opts)
end

-- 1. Copilot
nmap("<Leader>ce", ":Copilot enable<CR>", "Copilot Enable")
nmap("<Leader>cd", ":Copilot disable<CR>", "Copilot Disable")

-- Copilot accept mapping in Insert mode (Meta + l)
imap("<M-l>", 'copilot#Accept("<CR>")', "Accept Copilot suggestion", { expr = true })

-- Prevent <Tab> from being mapped by Copilot, if desired
vim.g.copilot_no_tab_map = true

-- 2. General Mappings
nmap(";", ":", "Mode enter command")
imap("jk", "<ESC>", "Mode exit insert")

-- 3. Git Mappings
nmap("<Leader>gg", ":G<CR>", "Git status")
nmap("<Leader>gz", ":FloatermNew LazyGit<CR>", "Git Open Lazygit")

-- Disable entering Command-line mode in LazyGit terminal
local gitGroup = vim.api.nvim_create_augroup("LazyGitFixes", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
   group = gitGroup,
   pattern = "term://*lazygit*",
   callback = function()
      vim.keymap.set("t", ":", "<Nop>", { noremap = true, silent = true, buffer = 0 })
   end,
})

-- 4. Theme Picker / Colors
nmap("<leader-th>", function()
   require("nvchad.themes").open({
      icon = "",
      style = "compact", -- or "flat", "bordered", etc.
   })
end, "Open NvChad theme picker")

nmap("<Leader>to", function()
   require("minty.huefy").open({ border = true })
end, "Picker Fancy color finder")

-- 5. Menu (e.g. for RightMouse or <C-t>)
nmap("<C-t>", function()
   require("menu").open("default")
end, "Open menu (default)")

nmap("<RightMouse>", function()
   -- Temporarily pass right-click to normal mode
   vim.cmd.exec('"normal! \\<RightMouse>"')
   -- Decide which menu to open, based on filetype
   local opts = (vim.bo.filetype == "NvimTree") and "nvimtree" or "default"
   require("menu").open(opts, { mouse = true })
end, "Open menu (mouse)")

-- 6. TODO-Comments Navigation
nmap("]t", function()
   require("todo-comments").jump_next()
end, "Todo comment next")

nmap("[t", function()
   require("todo-comments").jump_prev()
end, "Todo comment previous")

-- 7. Floaterm (Floating Terminal) Mappings
nmap("<Leader>tN", "<cmd>FloatermNew<CR>", "Floaterm New terminal")
nmap("<Leader>tt", "<cmd>FloatermToggle<CR>", "Floaterm Toggle terminal")
nmap("<Leader>tK", "<cmd>FloatermKill<CR>", "Floaterm Kill terminal")
nmap("<Leader>tn", "<cmd>FloatermNext<CR>", "Floaterm Next terminal")
nmap("<Leader>tp", "<cmd>FloatermPrev<CR>", "Floaterm Previous terminal")
nmap("<Leader>tA", "<cmd>FloatermKill!<CR>", "Floaterm Kill all terminals")

-- Floaterm configuration
vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.9
vim.g.floaterm_wintype = "float"
vim.g.floaterm_position = "center"

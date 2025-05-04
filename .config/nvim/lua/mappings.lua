-- Load NvChad's default mappings (if needed)
require("nvchad.mappings")

-- +-----------------------------------------------------------+
-- | Helper Functions                                          |
-- +-----------------------------------------------------------+

-- A small helper to define normal‑mode maps with common defaults
local function nmap(lhs, rhs, desc, opts)
    local default_opts = { desc = desc, noremap = true, silent = true }
    if opts then
        default_opts = vim.tbl_extend("force", default_opts, opts)
    end
    vim.keymap.set("n", lhs, rhs, default_opts)
end

-- A small helper to define insert‑mode maps
local function imap(lhs, rhs, desc, opts)
    local default_opts = { desc = desc, noremap = true, silent = true }
    if opts then
        default_opts = vim.tbl_extend("force", default_opts, opts)
    end
    vim.keymap.set("i", lhs, rhs, default_opts)
end

-- +-----------------------------------------------------------+
-- | 0. ToggleTerm ‑‑ global setup + default mapping           |
-- +-----------------------------------------------------------+

require("toggleterm").setup({
    open_mapping = [[<C-\>]], -- default from ToggleTerm README
    insert_mappings = true,
    terminal_mappings = true,
    direction = "float",
})

-- Lazygit helper terminal
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

-- +-----------------------------------------------------------+
-- | 1. General Mappings                                       |
-- +-----------------------------------------------------------+

nmap(";", ":", "Mode enter command")
imap("jk", "<ESC>", "Mode exit insert")

-- +-----------------------------------------------------------+
-- | 2. Git Mappings                                           |
-- +-----------------------------------------------------------+

-- \<leader> gg  → Fugitive status (classic)
nmap("<Leader>gg", ":G<CR>", "Git status (Fugitive)")

-- \<leader> gz  → Lazygit inside floating ToggleTerm
nmap("<Leader>gz", function()
    lazygit:toggle()
end, "Git Open Lazygit (ToggleTerm)")

-- Disable entering Command‑line mode in Lazygit terminal
local gitGroup = vim.api.nvim_create_augroup("LazyGitFixes", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = gitGroup,
    pattern = "term://*lazygit*",
    callback = function()
        vim.keymap.set("t", ":", "<Nop>", { noremap = true, silent = true, buffer = 0 })
    end,
})

-- +-----------------------------------------------------------+
-- | 3. Theme Picker / Colors                                  |
-- +-----------------------------------------------------------+

nmap("<leader-th>", function()
    require("nvchad.themes").open({ icon = "", style = "compact" })
end, "Open NvChad theme picker")

nmap("<Leader>to", function()
    require("minty.huefy").open({ border = true })
end, "Picker Fancy color finder")

-- +-----------------------------------------------------------+
-- | 4. Menu (RightMouse & <C-t>)                              |
-- +-----------------------------------------------------------+

nmap("<C-t>", function()
    require("menu").open("default")
end, "Open menu (default)")

nmap("<RightMouse>", function()
    vim.cmd.exec('"normal! \\<RightMouse>"')
    local opts = (vim.bo.filetype == "NvimTree") and "nvimtree" or "default"
    require("menu").open(opts, { mouse = true })
end, "Open menu (mouse)")

-- +-----------------------------------------------------------+
-- | 5. TODO‑Comments Navigation                               |
-- +-----------------------------------------------------------+

nmap("]t", function()
    require("todo-comments").jump_next()
end, "Todo comment next")

nmap("[t", function()
    require("todo-comments").jump_prev()
end, "Todo comment previous")

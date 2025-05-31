pcall(vim.loader.enable)

-- 0.  Base NvChad mappings (leave as-is)
require("nvchad.mappings")

-- Helper to DRY normal/insert mappings
local function map(mode, lhs, rhs, desc, opts)
    vim.keymap.set(
        mode,
        lhs,
        rhs,
        vim.tbl_extend("force", { desc = desc, noremap = true, silent = true }, opts or {})
    )
end
local function nmap(lhs, rhs, desc, opts)
    map("n", lhs, rhs, desc, opts)
end
local function imap(lhs, rhs, desc, opts)
    map("i", lhs, rhs, desc, opts)
end

-- 1.  ToggleTerm  + LazyGit terminal
require("toggleterm").setup({
    open_mapping = [[<C-\>]],
    insert_mappings = true,
    terminal_mappings = true,
    direction = "float",
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

-- 2.  General mappings
nmap(";", ":", "Enter command-line")
imap("jk", "<Esc>", "Leave insert mode")

-- 3.  Git helpers
nmap("<Leader>gg", ":G<CR>", "Git status (Fugitive)")
nmap("<Leader>gz", function()
    lazygit:toggle()
end, "Toggle LazyGit")

-- Disable “:” inside the LazyGit TUI
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("LazyGitFixes", { clear = true }),
    pattern = "term://*lazygit*",
    callback = function()
        vim.keymap.set("t", ":", "<Nop>", { buffer = 0, noremap = true, silent = true })
    end,
})

-- 4.  Theme / colour pickers
nmap("<leader>th", function()
    require("nvchad.themes").open({ icon = "", style = "compact" })
end, "Open NvChad theme picker")

nmap("<Leader>to", function()
    require("minty.huefy").open({ border = true })
end, "Picker Fancy color finder")

-- 5.  Popup menu (keyboard & mouse)
nmap("<C-t>", function()
    require("menu").open("default")
end, "Open menu")

nmap("<RightMouse>", function()
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<RightMouse>", true, false, true),
        "n",
        false
    )
    local preset = (vim.bo.filetype == "NvimTree") and "nvimtree" or "default"
    require("menu").open(preset, { mouse = true })
end, "Open menu (mouse)")

-- 6.  TODO-comments navigation
nmap("]t", function()
    require("todo-comments").jump_next()
end, "Next TODO")
nmap("[t", function()
    require("todo-comments").jump_prev()
end, "Prev TODO")

-- 7. Diagnostics helpers
nmap("<Leader>wo", function()
    local cfg = vim.diagnostic.config()
    vim.diagnostic.config({ virtual_text = not cfg.virtual_text })
end, "Toggle diagnostics virtual-text")

local diag_float = { win = nil }
local function toggle_diag_float()
    if diag_float.win and vim.api.nvim_win_is_valid(diag_float.win) then
        vim.api.nvim_win_close(diag_float.win, true)
        diag_float.win = nil
        return
    end
    local _, win = vim.diagnostic.open_float(nil, { -- Fixed this line
        close_events = { "CursorMoved", "BufHidden", "InsertEnter", "WinScrolled" },
    })
    diag_float.win = win
end
vim.keymap.set(
    "n",
    "<Leader>we",
    toggle_diag_float,
    { desc = "Toggle diagnostic float preview", noremap = true, silent = true }
)

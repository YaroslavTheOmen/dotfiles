-- Load NvChad's default mappings (if needed)
require("nvchad.mappings")

local function nmap(lhs, rhs, desc, opts)
    local default_opts = { desc = desc, noremap = true, silent = true }
    if opts then
        default_opts = vim.tbl_extend("force", default_opts, opts)
    end
    vim.keymap.set("n", lhs, rhs, default_opts)
end

local function imap(lhs, rhs, desc, opts)
    local default_opts = { desc = desc, noremap = true, silent = true }
    if opts then
        default_opts = vim.tbl_extend("force", default_opts, opts)
    end
    vim.keymap.set("i", lhs, rhs, default_opts)
end

nmap(";", ":", "Mode enter command")
imap("jk", "<ESC>", "Mode exit insert")

nmap("<Leader>gg", ":G<CR>", "Git status")
nmap("<Leader>gz", ":FloatermNew LazyGit<CR>", "Git Open Lazygit")

local gitGroup = vim.api.nvim_create_augroup("LazyGitFixes", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = gitGroup,
    pattern = "term://*lazygit*",
    callback = function()
        vim.keymap.set("t", ":", "<Nop>", { noremap = true, silent = true, buffer = 0 })
    end,
})

nmap("<leader-th>", function()
    require("nvchad.themes").open({
        icon = "",
        style = "compact", -- or "flat", "bordered", etc.
    })
end, "Open NvChad theme picker")

nmap("<Leader>to", function()
    require("minty.huefy").open({ border = true })
end, "Picker Fancy color finder")

-- for RightMouse or <C-t>
nmap("<C-t>", function()
    require("menu").open("default")
end, "Open menu (default)")

nmap("<RightMouse>", function()
    vim.cmd.exec('"normal! \\<RightMouse>"')
    local opts = (vim.bo.filetype == "NvimTree") and "nvimtree" or "default"
    require("menu").open(opts, { mouse = true })
end, "Open menu (mouse)")

nmap("]t", function()
    require("todo-comments").jump_next()
end, "Todo comment next")

nmap("[t", function()
    require("todo-comments").jump_prev()
end, "Todo comment previous")

nmap("<Leader>tN", "<cmd>FloatermNew<CR>", "Floaterm New terminal")
nmap("<Leader>tt", "<cmd>FloatermToggle<CR>", "Floaterm Toggle terminal")
nmap("<Leader>tK", "<cmd>FloatermKill<CR>", "Floaterm Kill terminal")
nmap("<Leader>tn", "<cmd>FloatermNext<CR>", "Floaterm Next terminal")
nmap("<Leader>tp", "<cmd>FloatermPrev<CR>", "Floaterm Previous terminal")
nmap("<Leader>tA", "<cmd>FloatermKill!<CR>", "Floaterm Kill all terminals")

vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.9
vim.g.floaterm_wintype = "float"
vim.g.floaterm_position = "center"

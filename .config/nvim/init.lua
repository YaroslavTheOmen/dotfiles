-- ── core paths & leader ────────────────────────────────────────────────────────
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- ── extra runtime/host settings ───────────────────────────────────────────────
vim.o.shell = "/opt/homebrew/bin/fish"
vim.g.python3_host_prog = "/Users/yaroslavaugustus/.config/nvim/venv/bin/python3"
vim.g.loaded_python3_provider = 1 -- use the venv above

-- ── diagnostics: hide virtual-text while typing ───────────────────────────────
local vt_grp = vim.api.nvim_create_augroup("ToggleVirtualText", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vt_grp,
    callback = function()
        vim.diagnostic.config({ virtual_text = false })
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = vt_grp,
    callback = function()
        vim.diagnostic.config({ virtual_text = true })
    end,
})

-- ── terminal-window look & feel ───────────────────────────────────────────────
local term_pad_grp = vim.api.nvim_create_augroup("TerminalPadding", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = term_pad_grp,
    pattern = "*",
    callback = function()
        local win = vim.api.nvim_get_current_win()
        vim.wo[win].signcolumn = "no"
        vim.wo[win].foldcolumn = "2"
        vim.wo[win].number = false
        vim.wo[win].relativenumber = false
    end,
})

-- ── blinking-cursor fix (no blinking anywhere) ────────────────────────────────
vim.opt.guicursor = table.concat({
    "n-v-c:block", -- normal / visual / command
    "i-ci-ve:ver25", -- insert / command-insert / visual-ex
    "o:hor20", -- operator-pending
    "t:block", -- terminal
    "a:blinkon0", -- disable blinking globally
}, ",")

-- ── NvChad bootstrap (unchanged, takes priority) ──────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },
    { import = "plugins" },
}, lazy_config)

-- ── theme & user-side config load order ───────────────────────────────────────
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("options") -- your own options module
require("nvchad/autocmds") -- your custom autocmds (just "autocmds" in original init.lua)

vim.schedule(function()
    require("mappings") -- keep mappings lazy-loaded
end)

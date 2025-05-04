vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- Added by me
vim.o.shell = "/opt/homebrew/bin/fish"
vim.g.python3_host_prog = "/Users/yaroslavaugustus/.config/nvim/venv/bin/python3"
vim.g.loaded_python3_provider = 1

-- Missing virtual_text fix
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})

-- terminal padding fix
vim.api.nvim_create_augroup("TerminalPadding", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = "TerminalPadding",
    pattern = "*",
    callback = function()
        local win = vim.api.nvim_get_current_win()
        vim.wo[win].signcolumn = "no"
        vim.wo[win].foldcolumn = "2"
        vim.wo[win].number = false
        vim.wo[win].relativenumber = false
    end,
})

-- blinking cursor fix
vim.opt.guicursor = "n-v-c:block,i:ver25,r-cr:hor20,a:blinkon0-blinkoff0"

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
        config = function()
            require("options")
        end,
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("options")
require("nvchad.autocmds")

vim.schedule(function()
    require("mappings")
end)

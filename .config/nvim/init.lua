vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "
vim.o.shell = "/opt/homebrew/bin/fish"
vim.g.python3_host_prog = "/Users/yaroslavaugustus/.config/nvim/venv/bin/python3"
vim.g.loaded_python3_provider = 1
vim.lsp.handlers["textDocument/hover"] =
   vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] =
   vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
   dofile(vim.g.base46_cache .. v)
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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

require("nvchad.autocmds")

vim.schedule(function()
   require("mappings")
end)

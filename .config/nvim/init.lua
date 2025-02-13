vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- Added by me
vim.o.shell = "/opt/homebrew/bin/fish"
vim.g.python3_host_prog = "/Users/yaroslavaugustus/.config/nvim/venv/bin/python3"
vim.g.loaded_python3_provider = 1

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

-- RustAnalyzer Bug fix
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
   local default_diagnostic_handler = vim.lsp.handlers[method]
   vim.lsp.handlers[method] = function(err, result, context, config)
      if err ~= nil and err.code == -32802 then
         return
      end
      return default_diagnostic_handler(err, result, context, config)
   end
end

-- RustAnalyzer Bug fix
vim.g.rustaceanvim = {
   tools = {},
   server = {
      -- TODO: Fix this https://github.com/hrsh7th/cmp-nvim-lsp/issues/72
      capabilities = vim.lsp.protocol.make_client_capabilities(),
   },
}

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

vim.o.shell = "/opt/homebrew/bin/fish" -- "/usr/bin/fish"
vim.g.python3_host_prog = "~/.config/nvim/venv/bin/python3"
vim.g.loaded_python3_provider = 1

-- Turn On/Off virtual_text on InsertLeave/InsertEnter
local grp = vim.api.nvim_create_augroup("DiagVirtualTextOnInsert", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = grp,
  callback = function(args)
    vim.diagnostic.config({ virtual_text = false }, args.buf)
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = grp,
  callback = function(args)
    vim.diagnostic.config({ virtual_text = true }, args.buf)
  end,
})

-- Set Style fo FloatWindows
local float = {
  border = "rounded",
  focusable = false,
  source = "if_many",
  header = "",
}
vim.diagnostic.config { severity_sort = true, float = float }

local orig_open = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or float.border
  opts.focusable = opts.focusable ~= nil and opts.focusable or float.focusable
  return orig_open(contents, syntax, opts, ...)
end
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Comment" })

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

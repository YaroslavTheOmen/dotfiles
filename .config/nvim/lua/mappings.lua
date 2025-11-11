require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map({ "n", "v" }, "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true, border = true })
end)

map("n", "<A-b>", function()
  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options)
end)

map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

local function toggle_lazygit()
  local ok, term = pcall(require, "toggleterm.terminal")
  if not ok then
    vim.notify("toggleterm not available", vim.log.levels.WARN)
    return
  end
  _LAZYGIT_TERM = _LAZYGIT_TERM
    or term.Terminal:new {
      cmd = "lazygit",
      hidden = true,
      direction = "float",
    }
  _LAZYGIT_TERM:toggle()
end

map("n", "<Leader>gz", toggle_lazygit, { desc = "Toggle LazyGit (float)" })

map("n", "<Leader>wo", function()
  local cfg = vim.diagnostic.config()
  vim.diagnostic.config { virtual_text = not cfg.virtual_text }
end, { desc = "Toggle diagnostics virtual-text" })


local diag_float = { win = nil }
local function toggle_diag_float()
  if diag_float.win and vim.api.nvim_win_is_valid(diag_float.win) then
    vim.api.nvim_win_close(diag_float.win, true)
    diag_float.win = nil
    return
  end
  diag_float.win = vim.diagnostic.open_float(nil, {
    close_events = { "CursorMoved", "BufHidden", "InsertEnter", "WinScrolled" },
  })
end

map("n", "<Leader>we", toggle_diag_float, { desc = "Toggle diagnostic float preview" })

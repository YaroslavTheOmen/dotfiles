require("nvchad.mappings")
pcall(vim.loader.enable)

vim.opt.mousemodel = "extend"

-- Small helper so we don’t repeat the opts table every time
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

-- 1. ToggleTerm + floating LazyGit
require("toggleterm").setup({
  open_mapping = [[<C-\>]],
  insert_mappings = true,
  terminal_mappings = true,
  direction = "float",
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

-- 2. Context-menu on single right-click
local function open_context_menu()
  require("menu.utils").delete_old_menus()

  -- re-feed the original click so Neovim selects the correct window under cursor
  local codes = vim.api.nvim_replace_termcodes("<RightMouse>", true, false, true)
  vim.api.nvim_feedkeys(codes, "n", false)

  local mp = vim.fn.getmousepos()
  local buf = vim.api.nvim_win_get_buf(mp.winid)
  local preset = (vim.bo[buf].filetype == "NvimTree") and "nvimtree" or "default"

  require("menu").open(preset, { mouse = true })
end
vim.keymap.set({ "n", "v" }, "<RightMouse>", open_context_menu, { silent = true, noremap = true })

-- 3.  Keymaps
-- General
nmap(";", ":", "Enter command-line")
imap("jk", "<Esc>", "Leave insert mode")

-- Git
nmap("<Leader>gg", ":G<CR>", "Git status (Fugitive)")
nmap("<Leader>gz", function()
  lazygit:toggle()
end, "Toggle LazyGit")

-- Theme / colours
nmap("<Leader>th", function()
  require("nvchad.themes").open({ icon = "", style = "compact" })
end, "NvChad theme picker")

nmap("<Leader>to", function()
  require("minty.huefy").open({ border = true })
end, "Fancy colour picker")

-- Popup menu
nmap("<C-t>", function()
  require("menu").open("default")
end, "Open menu")

-- TODO-comments
nmap("]t", function()
  require("todo-comments").jump_next()
end, "Next TODO")
nmap("[t", function()
  require("todo-comments").jump_prev()
end, "Prev TODO")

-- Diagnostics helpers
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
  local win = vim.diagnostic.open_float(nil, {
    close_events = { "CursorMoved", "BufHidden", "InsertEnter", "WinScrolled" },
  })
  diag_float.win = win
end
nmap("<Leader>we", toggle_diag_float, "Toggle diagnostic float preview")

-- Crates.nvim
local crates = require("crates")
local opts = { silent = true }

nmap("<leader>ct", crates.toggle, "Rust Crate: Toggle")
nmap("<leader>cr", crates.reload, "Rust Crate: Reload")

nmap("<leader>cv", crates.show_versions_popup, "Rust Crate: Show Versions")
nmap("<leader>cf", crates.show_features_popup, "Rust Crate: Show Features")
nmap("<leader>cd", crates.show_dependencies_popup, "Rust Crate: Show Dependencies")

nmap("<leader>cu", crates.update_crate, "Rust Crate: Update (compatible)")
vim.keymap.set(
  "v",
  "<leader>cu",
  crates.update_crates,
  vim.tbl_extend("keep", opts, { desc = "Rust Crates: Update (sel.)" })
)
nmap("<leader>ca", crates.update_all_crates, "Rust Crates: Update All")

nmap("<leader>cU", crates.upgrade_crate, "Rust Crate: Upgrade (latest)")
vim.keymap.set(
  "v",
  "<leader>cU",
  crates.upgrade_crates,
  vim.tbl_extend("keep", opts, { desc = "Rust Crates: Upgrade (sel.)" })
)
nmap("<leader>cA", crates.upgrade_all_crates, "Rust Crates: Upgrade All")

nmap("<leader>cH", crates.open_homepage, "Rust Crate: Open Homepage")
nmap("<leader>cR", crates.open_repository, "Rust Crate: Open Repository")
nmap("<leader>cD", crates.open_documentation, "Rust Crate: Open Documentation")
nmap("<leader>cC", crates.open_crates_io, "Rust Crate: Open Crates.io")

-- Disable <tab> in DBUI
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dbui", "dbout" },
  callback = function(args)
    nmap("<Tab>", function()
      return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    end, "DBUI: Tab as Enter", { buffer = args.buf, expr = true })

    nmap("<S-Tab>", function()
      return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    end, "DBUI: S-Tab as Enter", { buffer = args.buf, expr = true })
  end,
})

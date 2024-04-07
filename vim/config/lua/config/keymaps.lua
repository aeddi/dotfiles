-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Rebind ESC (See better-escape plugin for insert mode)
map({ "c", "v" }, ";j", "<ESC>")

-- Yankless paste
map("x", "p", "P")

-- Switch between tabs
map("n", "{", "<cmd> tabprevious <CR>", { desc = "Previous tab" })
map("n", "}", "<cmd> tabnext <CR>", { desc = "Next tab" })

-- Go to start/end of line in insert mode
map("i", "<C-a>", "<ESC>^i", { desc = "Move to beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })

-- Move line up and down
map("n", "<C-S-j>", ":m .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })
map("n", "<C-S-k>", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })
map("i", "<C-S-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down", noremap = true, silent = true })
map("i", "<C-S-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up", noremap = true, silent = true })
map("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down", noremap = true, silent = true })
map("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up", noremap = true, silent = true })

-- Go to start/end of line in command mode
map("c", "<c-a>", "<Home>", { desc = "Move to beginning of command" })
map("c", "<c-e>", "<End>", { desc = "Move to end of command" })

-- Fix scroll on documentation popup open with <S-K>
map({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })
map({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })

-- Tui
local defaultLazytermOptions =
  { esc_esc = false, ctrl_hjkl = false, border = "rounded", size = { width = 0.8, height = 0.8 } }

-- Override LazyTerm to set a custom size
local lazyterm = function()
  LazyVim.terminal(nil, vim.tbl_deep_extend("force", defaultLazytermOptions, { cwd = LazyVim.root() }))
end
-- stylua: ignore
map("n", "<leader>fT", function() LazyVim.terminal(nil, defaultLazytermOptions) end, { desc = "Terminal (cwd)" })
map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

map("n", "<leader>tc", function()
  LazyVim.terminal({ "smassh" }, defaultLazytermOptions)
end, { desc = "Smassh typing test" })

map("n", "<leader>td", function()
  LazyVim.terminal({ "lazydocker" }, defaultLazytermOptions)
end, { desc = "Lazydocker" })

map("n", "<leader>tf", function()
  local max_width = math.floor(require("nui.utils").get_editor_size().width * 80 / 100 + 0.5)
  require("utils.popup").popup_cmd({
    cmd = "duf",
    args = { "--width", tostring(max_width) },
    env = vim.tbl_deep_extend("force", vim.fn.environ(), { CLICOLOR_FORCE = "true" }),
  }, "duf - Free disk space")
end, { desc = "Check free disk space" })

map("n", "<leader>tg", function()
  LazyVim.terminal({ "gh", "dash" }, defaultLazytermOptions)
end, { desc = "Github dashboard" })

map("n", "<leader>ti", function()
  require("utils.popup").popup_cmd(
    { cmd = "tokei", cwd = LazyVim.root.get({ normalize = true }) },
    "tokei - Code statistics"
  )
end, { desc = "Code dir stats" })

map("n", "<leader>tj", function()
  if vim.bo.filetype == "json" then
    LazyVim.terminal({ "jqp", "-f", vim.api.nvim_buf_get_name(0) }, defaultLazytermOptions)
  else
    print("Not a JSON file")
  end
end, { desc = "JQ playground" })

map("n", "<leader>tl", function()
  if vim.bo.filetype == "json" then
    LazyVim.terminal({ "jless", vim.api.nvim_buf_get_name(0) }, defaultLazytermOptions)
  else
    print("Not a JSON file")
  end
end, { desc = "JSON reader" })

map("n", "<leader>tp", function()
  LazyVim.terminal({ "gping", "google.com" }, defaultLazytermOptions)
end, { desc = "Ping google.com" })

map("n", "<leader>ts", function()
  LazyVim.terminal({ "sshs" }, defaultLazytermOptions)
end, { desc = "SSH connection" })

map("n", "<leader>tt", function()
  LazyVim.terminal({ "sudo", "termshark" }, defaultLazytermOptions)
end, { desc = "Termshark" })

map("n", "<leader>tu", function()
  LazyVim.terminal({ "dua", "i", LazyVim.root.get({ normalize = true }) }, defaultLazytermOptions)
end, { desc = "Disk usage analysis" })

map("n", "<leader>tw", function()
  require("utils.popup").popup_cmd({ cmd = "curl", args = { "wttr.in/porto-vecchio?QF" } }, "Porto-Vecchio Weather")
end, { desc = "Weather in Porto-Vecchio" })

map("n", "<leader>gz", function()
  LazyVim.terminal({ "npx", "cgz" }, defaultLazytermOptions)
end, { desc = "Conventionnal commit generator" })

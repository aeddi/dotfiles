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

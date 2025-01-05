-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Go to start/end of line in insert mode
map("i", "<C-a>", "<ESC>^i", { desc = "Move to beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })

-- Go to start/end of line in command mode
map("c", "<c-a>", "<Home>", { desc = "Move to beginning of command" })
map("c", "<c-e>", "<End>", { desc = "Move to end of command" })

-- Move line up and down
map("n", "<C-S-j>", ":m .+1<CR>==", { desc = "Move lines down", noremap = true, silent = true })
map("n", "<C-S-k>", ":m .-2<CR>==", { desc = "Move lines up", noremap = true, silent = true })
map("i", "<C-S-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move lines down", noremap = true, silent = true })
map("i", "<C-S-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move lines up", noremap = true, silent = true })
map("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down", noremap = true, silent = true })
map("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up", noremap = true, silent = true })

-- Focus Trouble panel
map("n", "<C-|>", function()
  require("trouble").focus(false)
end, { desc = "Focus Trouble panel", noremap = true, silent = true })

-- vim.keymap.del("i", ";")

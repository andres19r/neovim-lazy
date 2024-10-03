-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map("i", "jk", "<Esc>", { desc = "Change to normal mode" })
map("i", "fd", "<Esc>", { desc = "Change to normal mode" })
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Close neovim" })
map("n", "<leader>h", "<cmd>nohl<cr>", { desc = "Clear search highlights" })
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })
map("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open Lazy UI" })
map("n", "<leader>gn", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<A-l>", "<C-w>l", { desc = "Go to the left window"})
map("n", "<A-h>", "<C-w>h", { desc = "Go to the right window"})
map("n", "<A-j>", "<C-w>j", { desc = "Go to the down window"})
map("n", "<A-k>", "<C-w>k", { desc = "Go to the up window"})

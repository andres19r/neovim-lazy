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

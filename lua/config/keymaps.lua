local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("i", "jk", "<Esc>", { desc = "Change to normal mode" })
map("i", "fd", "<Esc>", { desc = "Change to normal mode" })
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Close neovim" })
map("n", "<leader>h", "<cmd>nohl<cr>", { desc = "Clear search highlights" })
map("n", "<leader>bD", "<cmd>%bdelete<cr>", { desc = "Delete all buffers" })
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })
map("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open Lazy UI" })
map("n", "<leader>gn", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<A-l>", "<C-w>l", { desc = "Go to the left window" })
map("n", "<A-h>", "<C-w>h", { desc = "Go to the right window" })
map("n", "<A-j>", "<C-w>j", { desc = "Go to the down window" })
map("n", "<A-k>", "<C-w>k", { desc = "Go to the up window" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

map("n", "<leader>wh", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to right window", remap = true })

map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bl", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit window" })
map("n", "<leader>wb", "<cmd>q<cr>", { desc = "Quit window" })
map("n", "<leader>qQ", "<cmd>Q<cr>", { desc = "Force quit window" })

map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

map("x", "@", function() return ":norm @" .. vim.fn.getcharstr() .. "<cr>" end, { expr = true })

map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>ws", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Previous Tab" })

map("n", "<leader>qf", function()
  require("quicker").toggle()
end, {
  desc = "Toggle quickfix",
})
map("n", "<leader>l", function()
  require("quicker").toggle({ loclist = true })
end, {
  desc = "Toggle loclist",
})
require("quicker").setup({
  keys = {
    {
      ">",
      function()
        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
})

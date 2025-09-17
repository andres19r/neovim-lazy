return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")
    local utils = require("telescope.utils")
    local builtin = require('telescope.builtin')
    local telescope = require("telescope")
    -- builtin.find_files({ previewer = false })
    vim.keymap.set('n', '<C-p>', function() builtin.find_files({ hidden = true, no_ignore = true }) end, {})
    -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>f.', function() builtin.find_files({ cwd = utils.buffer_dir() }) end, {})
    vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ss', builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end)
    vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>,', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    telescope.setup({
      defaults = {
        theme = "ivy",
        previewer = false,
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-f>"] = action_layout.toggle_preview,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "ivy",
          previewer = false,
        },
        git_files = {
          theme = "ivy",
          previewer = false,
        },
        live_grep = {
          theme = "ivy",
          previewer = false,
        },
        grep_string = {
          theme = "ivy",
          previewer = false,
        },
        current_buffer_fuzzy_find = {
          theme = "ivy",
          previewer = false,
        },
        buffers = {
          theme = "ivy",
          previewer = false,
        }
      }
    })
  end,
}

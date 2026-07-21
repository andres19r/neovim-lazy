return {
  {
    'stevearc/quicker.nvim',
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    config = function()
      require("mini.comment").setup()
    end,
  },
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      })
    end,
  },
  {
    "jedrzejboczar/possession.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("possession").setup({})
    end
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      lazygit = {
        enabled = true,
        config = {
          os = {
            edit =
            '[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "<CMD>q<CR>" && nvim --server "$NVIM" --remote {{filename}})',
            editAtLine =
            '[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "<CMD>q<CR>" &&  nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>")',
            editAtLineAndWait = "nvim +{{line}} {{filename}}",
            openDirInEditor =
            '[ -z "$NVIM" ] && (nvim -- {{dir}}) || (nvim --server "$NVIM" --remote-send "<CMD>q<CR>" && nvim --server "$NVIM" --remote {{dir}})',
          },
          promptToReturnFromSubprocess = false,
        },
      }
    },
    config = function(_, opts)
      require("snacks").setup(opts)
    end,
    keys = {
      { "<leader>lg", function() Snacks.lazygit.open() end,    desc = "Open Lazygit" },
      { "<leader>z",  function() Snacks.zen() end,             desc = "Toggle Zen Mode", },
      { "<leader>fe", function() Snacks.picker.explorer() end, desc = "FZF - Explorer" },
      { "<leader>ff", function() Snacks.picker.files() end,    desc = "FZF - Files" },
    }
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    keys = {
      { "<leader>ot", "<Cmd>ToggleTerm direction=float<CR>", desc = "Open term" },
      { "<leader>oT", "<Cmd>ToggleTerm direction=tab<CR>",   desc = "Open term maximized" },
    }
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  }
}

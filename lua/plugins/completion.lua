local defaults = require("config.defaults")

return {
  {
    "saghen/blink.cmp",
    enabled = true,
    lazy = false, -- lazy loading handled internally
    dependencies = {
      "folke/lazydev.nvim",
      "rafamadriz/friendly-snippets",
    },
    -- version = "1.*",
    build = "cargo build --release",
    opts = {
      fuzzy = { implementation = "prefer_rust" },
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = {
          "select_next",
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = {
          "select_next",
          "fallback",
        },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-x>"] = { "hide", "show", "fallback" },
      },
      appearance = {
        kind_icons = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "",
          Variable = "",
          Class = "",
          Interface = "",
          Module = "",
          Property = "",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
        },
        providers = {
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
          lsp = {
            opts = { tailwind_color_icon = "" },
            fallbacks = {},
          },
          snippets = {
            opts = {
              extended_filetypes = {
                typescript = { "javascript" },
                astro = { "javascript" },
              },
            },
          },
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          window = {
            border = "padded",
            max_width = math.floor(vim.o.columns / 4),
          },
        },
        trigger = {
          show_on_backspace = false,
          show_on_insert_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = {
            "'", '"', '(', '{', '['
          }
        },
        menu = {
          max_height = 6,
          -- border = "none",
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
      },
      signature = {
        enabled = false,
        window = {
          border = defaults.border,
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
}

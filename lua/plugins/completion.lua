return {
  {
    "saghen/blink.cmp",
    enabled = true,
    lazy = false, -- lazy loading handled internally
    dependencies = {
      "folke/lazydev.nvim",
      "rafamadriz/friendly-snippets",
    },
    -- version = "*",
    build = "1.*",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = {
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        -- ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
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
          show_on_backspace = true,
        },
        menu = {
          max_height = 6,
          border = "none",
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
      },
      signature = {
        enabled = false,
        window = {
          -- border = defaults.border,
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

return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- {
  --   'nvim-java/nvim-java',
  --   config = function()
  --     require('java').setup()
  --     vim.lsp.enable('jdtls')
  --   end,
  -- },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "pyright",
          "ts_ls",
          "angularls",
          "html",
          "cssls",
          "jsonls",
        },
        -- Inside your config function (where you see 'require('mason-lspconfig').setup')
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    depependencies = {
      "saghen/blink.cmp",
      -- "cmp-nvim-lsp",
    },
    config = function()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- capabilities.workspace = {
      --   didChangeWatchedFiles = {
      --     dynamicRegistration = true,
      --   },
      -- }
      local capabilities = require("blink.cmp").get_lsp_capabilities({
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      })
      local servers = {
        -- ... your existing servers (pyright, lua_ls, etc.) ...

        -- Add or modify these two entries:
        ts_ls = {
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vim.fn.stdpath('data') ..
                    '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                languages = { 'vue' },
              },
            },
          },
        },

        vue_ls = {}, -- Vue language server (handles template + CSS)

      }

      -- mason-lspconfig v2 auto-enables installed servers via vim.lsp.enable()
      -- using their bundled default config; this is the supported way to
      -- override/extend that default (e.g. adding `php` to emmet's filetypes).
      vim.lsp.config('emmet_language_server', {
        capabilities = capabilities,
        filetypes = {
          'astro', 'css', 'eruby', 'html', 'htmlangular', 'htmldjango',
          'javascriptreact', 'less', 'sass', 'scss', 'svelte',
          'typescriptreact', 'vue', 'php',
        },
      })


      -- Setup mason-lspconfig with handlers
      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })

      -- Ensure ts_ls attaches to Vue files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'vue',
        callback = function(args)
          local root_dir = vim.fs.root(args.buf, { 'package.json', 'tsconfig.json', 'jsconfig.json' })
          local init_options = vim.deepcopy(servers.ts_ls.init_options)

          local mason_path = vim.fn.stdpath('data') ..
              '/mason/packages/vue-language-server/node_modules/@vue/language-server'
          if vim.fn.isdirectory(mason_path) == 1 then
            init_options.plugins[1].location = mason_path
          end

          vim.lsp.start({
            name = 'ts_ls',
            cmd = { 'typescript-language-server', '--stdio' },
            root_dir = root_dir,
            init_options = init_options,
            capabilities = capabilities,
          })
        end,
      })
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
      -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set("n", "<space>wf", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)

      vim.diagnostic.config({
        underline = false,
        virtual_text = {
          spacing = 2,
          prefix = "●",
        },
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            -- Alas nerdfont icons don't render properly on Medium!
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })
    end,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "williamboman/mason-lspconfig.nvim",
  --     "saghen/blink.cmp",
  --   },
  --   config = function(_, opts)
  --     local lspconfig = require("lspconfig")
  --
  --     vim.api.nvim_create_autocmd("LspAttach", {
  --       group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  --       callback = function(ev)
  --         local opts = { buffer = bufnr, remap = false }
  --         vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  --         vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  --         vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  --         vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  --         vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  --         vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  --         vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  --         vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
  --         vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  --         vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  --         vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  --         vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  --         vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  --         vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  --         vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  --         vim.keymap.set("n", "<space>wf", function()
  --           print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --         end, opts)
  --         vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  --         vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  --         vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
  --         vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  --         vim.keymap.set("n", "<space>f", function()
  --           vim.lsp.buf.format({ async = true })
  --         end, opts)
  --       end,
  --     })
  --
  --     vim.diagnostic.config({
  --       underline = false,
  --       virtual_text = {
  --         spacing = 2,
  --         prefix = "●",
  --       },
  --       update_in_insert = false,
  --       severity_sort = true,
  --       signs = {
  --         text = {
  --           -- Alas nerdfont icons don't render properly on Medium!
  --           [vim.diagnostic.severity.ERROR] = " ",
  --           [vim.diagnostic.severity.WARN] = " ",
  --           [vim.diagnostic.severity.HINT] = " ",
  --           [vim.diagnostic.severity.INFO] = " ",
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    requires = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require('flutter-tools').setup {}
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
}

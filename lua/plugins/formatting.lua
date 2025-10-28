return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettier", "prettier", stop_after_first = true },
        typescript = { "prettier", "prettier", stop_after_first = true },
        javascriptreact = { "prettier", "prettier", stop_after_first = true },
        typescriptreact = { "prettier", "prettier", stop_after_first = true },
        css = { "prettier", "prettier", stop_after_first = true },
        html = { "prettier", "prettier", stop_after_first = true },
        htmlangular = { "prettier", "prettier", stop_after_first = true },
        json = { "prettier", "prettier", stop_after_first = true },
        yaml = { "prettier", "prettier", stop_after_first = true },
        markdown = { "prettier", "prettier", stop_after_first = true },
        sh = { "shfmt" },
      },
      -- format_on_save = function(bufnr)
      --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      --     return
      --   end
      --   return { timeout_ms = 500, lsp_fallback = true }
      -- end,
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}

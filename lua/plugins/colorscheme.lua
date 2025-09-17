return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "daltonmenezes/aura-theme",
    rtp = 'packages/neovim',
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
    end
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
  },
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "deep"
    },
    lazy = false,
    priority = 1000,
  },
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  }
}

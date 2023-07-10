return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "deus",
    },
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
  },
  {
    "overcache/NeoSolarized",
    lazy = true,
  },
  {
    "theniceboy/nvim-deus",
    lazy = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function()
      vim.g.catppuccin_flavour = "mocha"
    end,
  },
}

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
    config = function()
      vim.cmd(string.format("highlight TelescopeSelection guibg=#44475a"))
      vim.cmd(string.format("highlight WinSeparator guifg=#44475a"))
    end,
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

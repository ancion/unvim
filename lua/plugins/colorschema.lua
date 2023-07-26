return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
  },
  {
    "overcache/NeoSolarized",
    lazy = true,
  },
  {
    "theniceboy/nvim-deus",
    lazy = true,
    config = function()
      vim.cmd(string.format("highlight TelescopeSelection guibg=#44475a"))
      vim.cmd(string.format("highlight WinSeparator guifg=#44475a"))
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      vim.g.catppuccin_flavour = "mocha"
    end,
  },
}

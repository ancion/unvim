return {
  {
    "instant-markdown/vim-instant-markdown",
    ft = { "markdown" },
    build = "npm install",
    config = function()
      vim.g.instant_markdown_autostart = 0
      -- Fix markdown indentation settings
      vim.g.markdown_recommended_style = 0
    end,
  },
}

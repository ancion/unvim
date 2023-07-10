return {

  "nvim-telescope/telescope.nvim",
  commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = "> ",
    },
  },
  config = function()
    require("telescope").load_extension("projects")
  end,
}

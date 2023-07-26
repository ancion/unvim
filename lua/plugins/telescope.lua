return {
  "nvim-telescope/telescope.nvim",
  commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  opts = function()
    local icons = require("config.icons")
    return {
      defaults = {
        prompt_prefix = icons.separator.bold_right_arrow .. " ",
        selection_caret = icons.separator.right_arrow .. " ",
      },
    }
  end,
  config = function()
    require("telescope").load_extension("projects")
  end,
}

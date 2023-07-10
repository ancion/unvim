local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons = require("lazyvim.config").icons
    local Util = require("lazyvim.util")
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = {
          {
            "branch",
            icon = "",
          },
          {
            "mode",
            fmt = function(str)
              return " -- " .. str .. " -- "
            end,
            padding = { left = 0, right = 0 },
          },
        },
        lualine_b = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰫢 ",
            },
          },
        },
        lualine_c = {
          { "filename", path = 1, symbols = { modified = "  ", readonly = "  ", unnamed = " 󰑷 " } },
          {
            "diff",
            source = diff_source,
            symbols = {
              added = "+",
              modified = "~",
              removed = "-",
            },
            padding = { left = 2, right = 1 },
            color = {},
            cond = nil,
          },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Util.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.fg("Debug"),
          },
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
        },
        lualine_y = {
          {
            "o:encoding",
            fmt = string.upper,
            separator = "·",
            color = {},
          },
          { "filetype", padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
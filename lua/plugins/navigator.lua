return {
  {
    "ray-x/navigator.lua",
    config = function()
      require("navigator").setup({
        debug = false, -- log output, set to true and log path: ~/.cache/nvim/gh.log
        width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
        height = 0.3, -- max list window height, 0.3 by default
        preview_height = 0.35, -- max height of preview windows
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- border style, can be one of 'none', 'single', 'double',
        -- 'shadow', or a list of chars which defines the border
        on_attach = function(client, bufnr)
          require("illuminate").on_attach(client)
          if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
          end
          -- your hook
        end,
        -- put a on_attach of your own here, e.g
        -- function(client, bufnr)
        --   -- the on_attach will be called at end of navigator on_attach
        -- end,
        -- the attach code will apply to all lsp clients

        ts_fold = false, -- modified version of treesitter folding
        default_mapping = true, -- set to false if you will remap every key
        -- a list of key maps
        keymaps = {
          { key = "M", func = vim.lsp.buf.hover, desc = "hover" },
          { key = "<Leader>la", func = require("navigator.codeAction").code_action, desc = "code_action" },
          {
            key = "<Leader>lA",
            func = require("navigator.codeAction").range_code_action,
            desc = "range_code_action",
          },
        },
        -- this kepmap gk will override "gd" mapping function declaration()  in default kepmap
        -- please check mapping.lua for all keymaps
        treesitter_analysis = true, -- treesitter variable context
        treesitter_analysis_max_num = 100, -- how many items to run treesitter_analysis
        treesitter_analysis_condense = true, -- condense form form treesitter_analysis
        transparency = 70, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it
        lsp_signature_help = true, -- if you would like to hook ray-x/lsp_signature plugin in navigator
        lsp_signature_cfg = nil,
        mason = true,
      })
    end,
  },
  {
    "ray-x/guihua.lua",
    run = "cd lua/fzy && make",
  },
}

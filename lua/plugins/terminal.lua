--- Get current buffer size
---@return {width: number, height: number}
local function get_buf_size()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

--- Get the dynamic terminal size in cells
---@param direction number
---@param size number
---@return integer
local function get_dynamic_terminal_size(direction, size)
  size = size or 20
  if direction ~= "float" and tostring(size):find(".", 1, true) then
    size = math.min(size, 1.0)
    local buf_sizes = get_buf_size()
    local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
    return buf_size * size
  else
    return size
  end
end
return {
  "akinsho/toggleterm.nvim",
  branch = "main",
  opts = {
    -- size can be a number or function which is passed the current terminal
    size = 20,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = nil, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      border = "curved",
      -- width = <value>,
      -- height = <value>,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  init = function()
    -- Add executables on the config.lua
    -- { cmd, keymap, description, direction, size }
    -- lvim.builtin.terminal.execs = {...} to overwrite
    -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    -- TODO: pls add mappings in which key and refactor this
    local execs = {
      { nil, "<M-1>", "Horizontal Terminal", "horizontal", 0.3 },
      { nil, "<M-2>", "Vertical Terminal", "vertical", 0.4 },
      { nil, "<M-3>", "Float Terminal", "float", nil },
    }
    local exec_toggle = function(opts)
      local Terminal = require("toggleterm.terminal").Terminal
      local term = Terminal:new({ cmd = opts.cmd, count = opts.count, direction = opts.direction })
      term:toggle(opts.size, opts.direction)
    end
    local add_exec = function(opts)
      local binary = opts.cmd:match("(%S+)")
      if vim.fn.executable(binary) ~= 1 then
        return
      end
      vim.keymap.set({ "n", "t" }, opts.keymap, function()
        exec_toggle({ cmd = opts.cmd, count = opts.count, direction = opts.direction, size = opts.size() })
      end, { desc = opts.label, noremap = true, silent = true })
    end
    for i, exec in pairs(execs) do
      local direction = exec[4]
      local opts = {
        cmd = exec[1] or vim.o.shell,
        keymap = exec[2],
        label = exec[3],
        -- NOTE: unable to consistently bind id/count <= 9, see #2146
        count = i + 100,
        direction = direction,
        size = function()
          return get_dynamic_terminal_size(direction, exec[5])
        end,
      }
      add_exec(opts)
    end
  end,
  cmd = {
    "ToggleTerm",
    "TermExec",
    "ToggleTermToggleAll",
    "ToggleTermSendCurrentLine",
    "ToggleTermSendVisualLines",
    "ToggleTermSendVisualSelection",
  },
  keys = [[<c-\>]],
}

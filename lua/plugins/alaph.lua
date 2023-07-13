local header = {
  "                                                          ..:---====---::...                                                              ",
  "                                                      .-=+***++++===----:::..                                                             ",
  "                                                   -+*##****+++++====---:::..                                                             ",
  "                                                :+#######******+++====--:::...             ...........................                    ",
  "                                              -*%%########*****+++====--:::...              .:::::::::::::::::::::..::::::......          ",
  "                                            :*%%%%%%######*****+++====--:::...               .--------------::::...                       ",
  "                                           =%%%%%%%%######*****+++===---:::...                 ......                                 .   ",
  "                                         .*%%%%%%%%%######****++++===---:::...                                                      ...:  ",
  "                                    ....:#%%%%%%%%%%#####*****+++====---:::...                                                   ......:  ",
  "                              ....::::::*%%%%%%%%%%######****++++===---:::...                                              ..:. .:....:.  ",
  "                         ......:::::---+%%%%%%%%%%######****++++====---:::...                                         ..:----. .......    ",
  "                    .......::::-----:::#%%%%%%%%#######****+++++===---::::...                                    ..::-----:. .......      ",
  "                .......:::-----:::... -%%%%%%%%#######*****++++====---:::....                                 .:::-----::.........        ",
  "            ...:....::-----:::..      =%%%%%%%%#######*****++++====---:::...                               ..:::----::........            ",
  "         ........::----::::.          =%%%%%%%%%%%#####*****+++====---:::...                           ..::-----::.........               ",
  "      ........::-----:::..            :%%%%%%%%%%%%#####****+++===---:::...                       ..:::----:::.........                   ",
  "    ....... .:------:::.               #%%%%%%%%%%######***+++====---::...                  ...::-----::::........                        ",
  "  ........ :-:---:-::::.               -%%%%%%%%%######****+++===---:::..            ...:::------::::........                             ",
  " ........ .-::------::::.               +%%%%%%%%%####****+++===--:::....    ....:::------::::::.......                                   ",
  " ......... .----------::::...            -+**********+++====----:::::::::::-------::::::::.......                                         ",
  "  ......... ..::-----------:::::::........:-----------------------------::::::::::.......                                                 ",
  "    ..............::::-----------------------------------------:::::::::::.......                                                         ",
  "        .....::::.........:::::::::::::::::::::::::::::::::::::::::....                                                                   ",
  "               ........::::::::::::::::::::.....:::.....                                                                                  ",
  "                                               .....                                                                                      ",
}

local function max_len_line(lines)
  local max_len = 0

  for _, line in ipairs(lines) do
    local line_len = line:len()
    if line_len > max_len then
      max_len = line_len
    end
  end

  return max_len
end
local function align_center(container, lines, alignment)
  local output = {}
  local max_len = max_len_line(lines)

  for _, line in ipairs(lines) do
    local padding = string.rep(" ", (math.max(container.width, max_len) - line:len()) * alignment)
    table.insert(output, padding .. line)
  end

  return output
end

local plugin_num = #vim.fn.globpath(vim.call("stdpath", "data") .. "/site/pack/lazy/opt", "*", 0, 1)
local nvim_version = 10.0
local footer = {
  "",
  "                   :: Neovim loaded  " .. plugin_num .. " plugins   ",
  "---------------------------------------------------------------------",
  "                   :: Version :  [ " .. nvim_version .. " ]         ",
  "",
  [[#####################################################################]],
  [[|########## \\ 🪶:: Talk is cheap, show me you code !! // ##########|]],
  [[#####################################################################]],
}

return {
  {
    "goolord/alpha-nvim",
    dependency = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = header
      dashboard.section.footer.val = footer
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", "󰯃 " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("s", "󱛊 " .. " Recent project", ":Telescope projects<CR>"),
        dashboard.button("g", "󱘢 " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("q", "󰿅 " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "Number"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "Function"
      dashboard.opts.layout[1].val = 2
      return dashboard
    end,
  },
}

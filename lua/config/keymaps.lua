local Util = require("lazyvim.util")
-- lazygit
local lazygit = {
  open_with_root_dir = function()
    return Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false })
  end,
  open_with_cwd = function()
    return Util.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
  end,
}

-- floating terminal
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end

-- ui toggle
local ui = {
  toggle_format_on_save = function()
    return require("lazyvim.plugins.lsp.format").toggle
  end,
  toggle_spell = function()
    Util.toggle("spell")
  end,
  toggle_wrap = function()
    Util.toggle("wrap")
  end,
  toggle_number = function()
    Util.toggle("relativenumber", true)
    Util.toggle("number")
  end,
  toggle_diagnostics = function()
    return Util.toggle_diagnostics
  end,
  toggle_conceallevel = function()
    local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
    Util.toggle("conceallevel", false, { 0, conceallevel })
  end,
  toggle_inlay_hint = function()
    vim.lsp.inlay_hint(0, nil)
  end,
  toggle_show_pos = function()
    return vim.show_pos
  end,
}

-- map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<leader>fT", function() Util.float_term() end, { desc = "Terminal (cwd)" })
local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local nmappings = {
  { from = "S",            to = ":w<CR>" },
  { from = "Q",            to = ":q<CR>" },

  -- Movement
  { from = "J",            to = "5j",                                   mode = mode_nv },
  { from = "K",            to = "5k",                                   mode = mode_nv },
  { from = "W",            to = "5w",                                   mode = mode_nv },
  { from = "E",            to = "5e",                                   mode = mode_nv },
  { from = "H",            to = "0",                                    mode = mode_nv },
  { from = "L",            to = "$",                                    mode = mode_nv },
  { from = "M",            to = "lua vim.lsp.buf.hover",                mode = mode_nv },
  { from = "<C-K>",        to = "5<C-y>",                               mode = mode_nv },
  { from = "<C-J>",        to = "5<C-e>",                               mode = mode_nv },

  -- move up down
  { from = "<A-j>",        to = ":m '>+1<cr>gv=gv",                     mode = mode_v },
  { from = "<A-k>",        to = ":m '<-2<cr>gv=gv",                     mode = mode_v },

  -- indent
  { from = "<",            to = "<gv",                                  mode = mode_v },
  { from = ">",            to = ">gv",                                  mode = mode_v },

  -- insert supet
  { from = "<C-a>",        to = "<ESC>A",                               mode = mode_i },
  { from = "<C-o>",        to = "<ESC>o",                               mode = mode_i },
  { from = "<C-j>",        to = "pumvisible() ? '\\<C-n>' : '\\<C-j>'", mode = mode_i },
  { from = "<C-k>",        to = "pumvisible() ? '\\<C-p>' : '\\<C-k>'", mode = mode_i },
  { from = "jj",           to = "<ESC>",                                mode = mode_i },
  { from = "jk",           to = "<ESC>",                                mode = mode_i },

  -- Window & splits
  { from = "<C-k>",        to = "<C-w>k" },
  { from = "<C-j>",        to = "<C-w>j" },
  { from = "<C-h>",        to = "<C-w>h" },
  { from = "<C-l>",        to = "<C-w>l" },
  { from = "<up>",         to = ":res +5<CR>" },
  { from = "<down>",       to = ":res -5<CR>" },
  { from = "<left>",       to = ":vertical resize-5<CR>" },
  { from = "<right>",      to = ":vertical resize+5<CR>" },

  -- Other
  { from = "<leader>sw",   to = ":set wrap<CR>" },
  { from = "<leader><CR>", to = ":nohlsearch<CR>" },
  { from = "<leader>o",    to = "za" },
  { from = "<leader>rc",   to = ":e ~/.config/nvim/init.lua<CR>" },

  -- open app
  { from = "<leader>gg",   to = lazygit.open_with_root_dir,             opts = { desc = "open lazygit with root" } },
  { from = "<leader>gG",   to = lazygit.open_with_cwd,                  opts = { desc = "open lazygit with cwd" } },

  -- float terminal
  { from = "<A-1>",        to = lazyterm,                               opts = { desc = "open float terminal" } },
  { from = "<A-2>",        to = lazyterm,                               opts = { desc = "open float terminal" } },

  -- useful action
  { from = "<leader>bb",   to = "<cmd>e #<cr>" },
  { from = "\\s",          to = ":%s//g<left><left>" },

  -- quickfix navigator
  { from = "<leader>xl",   to = "<cmd>lopen<cr>" },
  { from = "<leader>xq",   to = "<cmd>copen<cr>" },

  -- quit
  { from = "<leader>qq",   to = "<cmd>qa<cr>" },

  -- ui toggle
  { from = "<leader>uf",   to = ui.toggle_format_on_save,               opts = { desc = "toggle format save" } },
  { from = "<leader>us",   to = ui.toggle_spell,                        opts = { desc = "toggle word spell" } },
  { from = "<leader>uw",   to = ui.toggle_wrap,                         opts = { desc = "toggle line wrap" } },
  { from = "<leader>ul",   to = ui.toggle_number,                       opts = { desc = "toggle line number" } },
  { from = "<leader>ud",   to = ui.toggle_diagnostics,                  opts = { desc = "toggle diagnostics" } },
  { from = "<leader>uc",   to = ui.toggle_conceallevel,                 opts = { desc = "toggle conceallevel" } },
  { from = "<leader>uh",   to = ui.toggle_inlay_hint,                   opts = { desc = "toggle inlay hint" } },
  { from = "<leader>ui",   to = ui.toggle_show_pos,                     opts = { desc = "show postion" } },
  { from = "<leader>ua",   to = "<cmd>Alpha<cr>",                       opts = { desc = "show home page" } },
  {
    from = "<leader>ur",
    to = "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>",
    opts = { desc = "Redraw/clear hlsearch / diff update" },
  },
}

for _, mapping in ipairs(nmappings) do
  local opts = mapping.opts or { noremap = true }
  vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, opts)
end

local function run_vim_shortcut(shortcut)
  local escaped_shortcut = vim.api.nvim_replace_termcodes(shortcut, true, false, true)
  vim.api.nvim_feedkeys(escaped_shortcut, "n", true)
end

-- close win below
vim.keymap.set("n", "<leader>q", function()
  vim.cmd("TroubleClose")
  local wins = vim.api.nvim_tabpage_list_wins(0)
  if #wins > 1 then
    run_vim_shortcut([[<C-w>j:q<CR>]])
  end
end, { noremap = true, silent = true })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- buffers
if Util.has("bufferline.nvim") then
  map("n", "<A-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<A-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

if not Util.has("trouble.nvim") then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<A-1>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<A-2>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

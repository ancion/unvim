-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- grepprg = "rg --vimgrep"
-- guifont = "FiraCode Nerd Font:h12"
-- lazyredraw = true
-- undolevels = 10000
-- winminwidth = 5     -- Minimum window width
-- updatetime = 200, -- Save swap file and trigger CursorHold
local option = {
  autowrite = true, -- Enable auto write
  autoindent = true,
  autochdir = true,
  cmdheight = 1,              -- command line height
  clipboard = "unnamedplus",  -- Sync with system clipboard
  completeopt = "longest,noinsert,menu,menuone,noselect,preview",
  conceallevel = 3,           -- Hide * markup for bold and italic"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable"
  confirm = true,             -- Confirm to save changes before exiting modified buffer
  cursorline = true,          -- Enable highlighting of the current line
  expandtab = true,           -- Use spaces instead of tabs
  formatoptions = "jcroqlnt", -- tcqj
  foldmethod = "indent",
  foldlevel = 9999,
  foldenable = true,
  grepformat = "%f:%l:%c:%m",
  ignorecase = true,      -- Ignore case
  inccommand = "nosplit", -- preview incremental substitute
  laststatus = 3,
  list = true,            -- Show some invisible characters (tabs...
  mouse = "a",            -- Enable mouse mode
  number = true,          -- Print line number
  pumblend = 10,          -- Popup blend
  pumheight = 20,         -- Maximum number of entries in a popup
  relativenumber = true,  -- Relative line numbers
  scrolloff = 10,         -- Lines of context
  sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
  shiftround = true,      -- Round indent
  shiftwidth = 2,         -- Size of an indent
  showmode = false,       -- Dont show mode since we have a statusline
  showcmd = true,
  sidescrolloff = 10,     -- Columns of context
  signcolumn = "yes",     -- Always show the signcolumn, otherwise it would shift the text each time
  smartcase = true,       -- Don't ignore case with capitals
  smartindent = true,     -- Insert indents automatically
  spelllang = { "en" },
  splitbelow = true,      -- Put new windows below current
  splitright = true,      -- Put new windows right of current
  tabstop = 2,            -- Number of spaces tabs count for
  termguicolors = true,   -- True color support
  timeoutlen = 300,
  textwidth = 0,
  undofile = true,
  viewoptions = "cursor,folds,slash,unix",
  visualbell = true,
  virtualedit = "block",
  wildmode = "longest:full,full", -- Command-line completion mode
  wildmenu = true,
  wrap = false,                   -- Disable line wrap
}

-- set option
for key, val in pairs(option) do
  vim.opt[key] = val
end

vim.opt.shortmess:append({ W = true, I = true, c = true })

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end

if vim.loop.os_uname().version:match "Windows" then
  -- if vim.fn.has("powershell") == 1 then
  vim.opt.shell = "powershell"
  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

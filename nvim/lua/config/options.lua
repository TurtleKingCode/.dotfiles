-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local state = require('config.state')

-- Indentation Settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true
opt.list = false

-- Show which line your cursor is on
opt.cursorline = false
opt.clipboard = ''

-- Terminal Configuration (OS-aware)
local platform = require('config.platform')
local shell_config = platform.get_shell_config()
opt.shell = shell_config.shell
opt.shellcmdflag = shell_config.shellcmdflag
opt.shellxquote = shell_config.shellxquote

-- Disabling Autoformat
vim.g.autoformat = false

-- vim.g.python3_host_prog = vim.fn.expand('~/AppData/Local/Programs/Python/Python313/python.exe')

opt.wrap = false
opt.linebreak = true
opt.background = state.background

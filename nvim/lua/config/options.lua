-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

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

-- Terminal Configuration
opt.shell = 'pwsh'
opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
opt.shellxquote = ''

-- Disabling Autoformat
-- vim.g.autoformat = false

-- vim.g.python3_host_prog = vim.fn.expand('~/AppData/Local/Programs/Python/Python313/python.exe')

opt.wrap = true
opt.linebreak = true

-- early stage implementation of personal persistent opts
local localopts = {}
localopts.transparent = vim.g.transparent_enabled

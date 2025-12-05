-- vim.cmd('source ~/AppData/Local/nvim/init.vim')
-- vim.cmd('source ~/.cache/calendar.vim/credentials.vim')

-- leader and localeader
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

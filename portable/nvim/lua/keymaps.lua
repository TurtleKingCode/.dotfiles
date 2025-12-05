-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>ql', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- vim.keymap.set('t', '<leader>h', '<C-\\><C-n><C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('t', '<leader>l', '<C-\\><C-n><C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('t', '<leader>j', '<C-\\><C-n><C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('t', '<leader>k', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local map = vim.keymap.set
local mapi = vim.api.nvim_set_keymap

-- map('n', '<leader>ee', vim.cmd.Ex)

map({ 'n', 'v', 'o' }, 'gl', '$')
map({ 'n', 'v', 'o' }, 'gh', '0')
map({ 'n', 'v', 'o' }, 'gm', '%')

map('i', '<C-h>', '<C-w>', { noremap = true, desc = 'delete word with backspace' }) -- Replace <C-h> if needed
map('c', '<C-h>', '<C-w>', { noremap = true, desc = 'delete word with backspace' }) -- For command-line mode

map({ 'v', 'n' }, '<leader>y', '"*y', { noremap = true })
map({ 'v', 'n' }, '<leader>p', '"*p', { noremap = true })
map({ 'v', 'n' }, '<leader>Y', '"*Y', { noremap = true })
map({ 'v', 'n' }, '<leader>P', '"*P', { noremap = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<leader>S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Quick Sub' })

vim.keymap.set('n', '<leader>so', ':source %<CR>', { desc = '[S][O]urcing file', silent = true })
vim.keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'E[x]ecute line' })
vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'E[x]ecute highlight' })

-- mapi('i', '<S-TAB>', '<Esc><<i', { noremap = false })

-- buffers

-- silent for buffers
mapi('n', 'tk', ':blast<CR>', { noremap = false, silent = true, desc = 'Tab Last' })
mapi('n', 'tj', ':bfirst<CR>', { noremap = false, silent = true, desc = 'Tab First' })
mapi('n', 'th', ':bprev<CR>', { noremap = false, silent = true, desc = 'Tab Prev' })
mapi('n', 'tl', ':bnext<CR>', { noremap = false, silent = true, desc = 'Tab Next' })
mapi('n', 'td', ':bdelete<CR>', { noremap = false, silent = true, desc = 'Tab Delete' })
mapi('n', 'to', ':enew<CR>', { noremap = false, silent = true, desc = 'Tab New' })
mapi('n', 'tD', ':bdelete!<CR>', { noremap = false, silent = true, desc = 'Tab DELETE!' })

-- spellcheck
mapi('n', '<leader>se', ':setlocal spell spelllang=en_us<CR>', { noremap = false })

-- Indenting --
map('v', '<', '<gv')
map('v', '>', '>gv')

mapi('n', 'QQ', ':q!<cr>', { noremap = false })
mapi('n', 'E', '$', { noremap = false })
mapi('n', 'B', '^', { noremap = false })

mapi('n', '<C-W>,', ':vertical resize -10<CR>', { noremap = true })
mapi('n', '<C-W>.', ':vertical resize +10<CR>', { noremap = true })
-- map('n', '<space><space>', "<cmd>set nohlsearch<CR>") <<- CHANGE: Unnecessary
-- Quicker close split
map('n', '<leader>qq', ':q<CR>', { silent = true, noremap = true })
-- map("n", "<leader>-", ":Ex<CR>", { silent = true, noremap = true })

map({ 'n', 'x', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ 'n', 'x', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<leader>dd', 'G:r !powershell -Command "Get-Date"<CR>', { noremap = true, silent = true })

vim.keymap.set('x', '<C-S-l>', '<cmd>lua print(vim.fn.wordcount().visual_words)<CR>')

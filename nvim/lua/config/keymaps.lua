-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- local lazymap = LazyVim.safe_keymap_set

-- STANDARD

-- navigation
map({ 'n', 'v', 'o' }, 'gl', '$', { desc = 'End of line' })
map({ 'n', 'v', 'o' }, 'gh', '0', { desc = 'Start of line' })
map({ 'n', 'v', 'o' }, 'gm', '%', { desc = 'Matching bracket' })

-- ctrl + backspace
map('i', '<C-h>', '<C-w>', { desc = 'Delete word with backspace' }) -- Replace <C-h> if needed
map('c', '<C-h>', '<C-w>', { desc = 'Delete word with backspace' }) -- For command-line mode

-- sourcing lua
map('n', '<leader>so', ':source %<CR>', { desc = 'Source file', silent = true })
map('n', '<leader>sx', ':.lua<CR>', { desc = 'Execute line', silent = true })
map('v', '<leader>sx', ':lua<CR>', { desc = 'Execute highlight', silent = true })

-- find & replace
-- map("v", "J", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
-- map("v", "K", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
map('n', '<leader>se', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Quick Sub', noremap = true })

-- yank, paste, and delete
map({ 'v', 'n' }, '<leader>y', '"*y', { noremap = true })
map({ 'v', 'n' }, '<leader>Y', '"*Y', { noremap = true })
map({ 'v', 'n' }, '<leader>p', '"*p', { noremap = true })
map({ 'v', 'n' }, '<leader>P', '"*P', { noremap = true })
map({ 'v', 'n' }, '<leader>d', '"*d', { noremap = true })
map({ 'v', 'n' }, '<leader>D', '"*D', { noremap = true })
map({ 'v', 'n' }, '<leader>c', '"*c', { noremap = true })
map({ 'v', 'n' }, '<leader>C', '"*C', { noremap = true })

-- paste date & time (OS-aware)
local platform = require('config.platform')
local date_cmd = platform.get_date_command()
map('n', '<leader>dd', 'G:r !' .. date_cmd .. '<CR>', { noremap = true, silent = true })
map('n', '<leader>ri', '<Esc>:r !', { noremap = true, silent = true })
map('n', '<leader>ro', function()
	local cmd = vim.fn.input('Shell command: ')
	local output = vim.fn.systemlist(cmd)
	vim.api.nvim_put(output, 'l', true, true)
end, { desc = 'Insert shell command output' })

map('x', '<leader>ro', function()
	-- Get visual selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.fn.getline(start_pos[2], end_pos[2])

	-- Trim line range if selection is partial
	lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
	lines[1] = string.sub(lines[1], start_pos[3])

	local command = table.concat(lines, '\n')

	-- Run the command via shell
	local output = vim.fn.systemlist(command)

	-- Insert below the end of the selection
	local insert_line = end_pos[2]
	vim.fn.append(insert_line, output)
end, { noremap = true, silent = true })

-- centering
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

---EDITOR

-- fzf-lua
map('n', '<leader>fP', LazyVim.pick('files', { cwd = '~/Projects/' }), { desc = 'Find in ~/Projects/' })
map('n', '<leader>fo', LazyVim.pick('files', { cwd = '~/Projects/Obsidian Vault/' }), { desc = 'Find in Obsidian Vault' })
map('n', '<leader>fd', LazyVim.pick('files', { cwd = platform.get_data_dir() }), { desc = 'Find Data File' })
map('n', '<leader>fD', LazyVim.pick('files', { cwd = '~/.dotfiles/' }), { desc = 'Find DotFile' })
local backup_dir = platform.get_backup_dir()
if backup_dir then
	map('n', '<leader>fC', LazyVim.pick('files', { cwd = backup_dir }), { desc = 'Find in Old Config' })
end

-- Snacks.toggle
-- Snacks.toggle.indent():set(false)
-- Snacks.toggle.animate():set(false)
Snacks.toggle.zen():map('<leader>zz')

-- vim.keymap.set('x', '<leader>ro', function()
--   local text = vim.fn.getreg('"'):sub(2) -- Get visual selection content, strip the "+ register
--   local cmd = vim.fn.input('Shell command: ')
--   local output = vim.fn.system(cmd .. ' <<< "' .. text .. '"')
--   vim.cmd('normal! "y')
--   vim.cmd('put _')
--   vim.cmd(output)
-- end, { desc = 'Pipe visual selection to shell command and insert output' })

-- Toggle distraction-free mode
local localopts = {}

localopts.nodistraction = false
localopts.lsp = true

-- Toggle distraction-free mode
map('n', '<leader>zm', function()
	localopts.nodistraction = not localopts.nodistraction

	if localopts.nodistraction then
		vim.opt.number = false
		vim.opt.relativenumber = false
		-- vim.opt.signcolumn = 'no' -- hide signs instead of showing them
		vim.opt.laststatus = 0
		vim.opt.showmode = false
		require('lualine').hide({
			place = {'statusline', 'winbar'}, -- The segment this change applies to.
			unhide = false,  -- whether to re-enable lualine again/
		})
		-- pcall(require('lualine').hide) -- safe call (won’t error if lualine not loaded)
	else
		vim.opt.number = true
		vim.opt.relativenumber = true
		-- vim.opt.signcolumn = 'yes'
		vim.opt.laststatus = 2
		vim.opt.showmode = true
		require('lualine').hide({ unhide = true })
		-- pcall(require('lualine').hide, { unhide = true })
	end
end, { desc = 'Toggle distraction-free mode' })

-- map('n', '<leader>zm', function()
-- 	localopts.nodistraction = not localopts.nodistraction
--
-- 	if localopts.nodistraction then
-- 		vim.opt.number = false
-- 		vim.opt.relativenumber = false
-- 		vim.opt.signcolumn = 'yes'
-- 		vim.opt.laststatus = 0 -- hide status line
-- 		require('lualine').hide()
-- 		vim.opt.showmode = false -- hide "-- INSERT --"
-- 		-- vim.opt.signcolumn = 'no' -- hide git/lsp signs
-- 		print('Distraction-free mode: ON')
-- 	else
-- 		vim.opt.number = true
-- 		vim.opt.relativenumber = true
-- 		vim.opt.laststatus = 2 -- show status line
-- 		require('lualine').hide({ unhide = true })
-- 		vim.opt.showmode = true
-- 		-- vim.opt.signcolumn = 'yes'
-- 		print('Distraction-free mode: OFF')
-- 	end
-- end, { desc = 'Toggle distraction-free mode' })

map('n', '<leader>zp', function()
	localopts.lsp = not localopts.lsp

	if localopts.lsp then
		vim.cmd('LspStart')
	else
		vim.cmd('LspStop')
	end
end, { desc = 'Toggle LSP' })

-- vid.keymap.del('n', '<leader>cp')
-- map('n', '<leader>cp', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })

-- map('n', 'i', 'zzi')
-- map('n', 'a', 'zza')
-- map('n', 'I', 'zzI')
-- map('n', 'A', 'zzA')
--
-- map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
-- map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
-- map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
-- map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

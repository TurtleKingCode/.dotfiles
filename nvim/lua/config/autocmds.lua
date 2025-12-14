-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = '*.kbd',
	callback = function()
		vim.bo.filetype = 'lisp'
	end,
})

-- Floating box on cursor hold
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
	group = vim.api.nvim_create_augroup('float_diagnostic', { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, {
			focus = false,
			border = 'rounded',
		})
	end,
})

-- Persist UI state on exit
local state_file = vim.fn.stdpath('config') .. '/lua/config/state.lua'

vim.api.nvim_create_autocmd('VimLeavePre', {
	-- Define an augroup to avoid duplicate autocmds on reload
	group = vim.api.nvim_create_augroup('SaveUIStateOnExit', { clear = true }),
	callback = function()
		local state = {
			background = vim.o.background,
			colorscheme = vim.g.colors_name, -- may be nil
		}

		local f, err = io.open(state_file, 'w')
		if not f then
			vim.notify('Failed to open state file: ' .. tostring(err), vim.log.levels.WARN)
			return
		end
		f:write('return ' .. vim.inspect(state))
		f:close()
		print('Updated State File')
	end,
})

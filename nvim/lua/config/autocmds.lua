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

vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
	group = vim.api.nvim_create_augroup('float_diagnostic', { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, {
			focus = false,
			border = 'rounded',
		})
	end,
})

-- local file_path = vim.fn.stdpath('data') .. '/last_colorscheme.lua'
--
-- local save_colorscheme = function(colorscheme)
--   vim.uv.fs_open(file_path, "w", 432, function(_, fd)
--     local string_to_write = "return " .. "'" .. colorscheme .. "'"
--     vim.uv.fs_write(fd, string_to_write, nil, function()
--       vim.uv.fs_close(fd)
--     end)
--   end)
-- end
--
-- save_colorscheme(vim.g.colors_name)
--
-- Compute path portably

-- Manage State
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

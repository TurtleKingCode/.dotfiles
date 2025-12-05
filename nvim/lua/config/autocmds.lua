-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_create_autocmd('VeryLazy', {
-- 	pattern = 'LazyVimStarted',
-- 	callback = function()
-- 		-- This will run after all plugins are loaded
-- 		local ok, Snacks = pcall(require, 'snacks')
-- 		if ok then
-- 			Snacks.toggle.indent():set(false)
-- 			Snacks.toggle.animate():set(false)
-- 			-- Now Snacks is available
-- 			-- Snacks.toggle.get('format'):set(false)
-- 			-- Snacks.toggle.get('pairs'):set(false)
-- 		end
-- 	end,
-- })

-- vim.api.nvim_create_autocmd('BufEnter', {
-- 	pattern = 'SnacksLoaded',
-- 	callback = function()
-- 		local Snacks = require('Snacks')
-- 		Snacks.toggle.indent():set(false)
-- 		Snacks.toggle.animate():set(false)
-- 		print('I hate you')
-- 	end,
-- })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = '*.kbd',
	callback = function()
		vim.bo.filetype = 'lisp'
	end,
})

-- -- Show LSP diagnostics (inlay hints) in a hover window / popup lamw26wmal
-- -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
-- -- https://www.reddit.com/r/neovim/comments/1168p97/how_can_i_make_lspconfig_wrap_around_these_hints/
-- -- If you want to increase the hover time, modify vim.o.updatetime = 200 in your
-- -- options.lua file
-- --
-- -- -- In case you want to use custom borders
-- -- local border = {
-- -- 	{ "🭽", "FloatBorder" },
-- -- 	{ "▔", "FloatBorder" },
-- -- 	{ "🭾", "FloatBorder" },
-- -- 	{ "▕", "FloatBorder" },
-- -- 	{ "🭿", "FloatBorder" },
-- -- 	{ "▁", "FloatBorder" },
-- -- 	{ "🭼", "FloatBorder" },
-- -- 	{ "▏", "FloatBorder" },
-- -- }
-- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
-- 	group = vim.api.nvim_create_augroup('float_diagnostic', { clear = true }),
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil, {
-- 			focus = false,
-- 			border = 'rounded',
-- 		})
-- 	end,
-- })

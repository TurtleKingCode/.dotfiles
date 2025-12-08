local platform = require('config.platform')

return {
	-- floatingtodo - custom: old nvim plugin
	{
		-- 'vimichael/floatingtodo.nvim',
		dir = '~/AppData/Local/nvim-backup/configs/longterm/nvim/lua/custom/plugins/floatingtodo.nvim/', -- Windows-only backup path
		enabled = platform.is_windows(), -- Only enable on Windows where backup exists
		opts = {
			target_file = '~/Projects/Obsidian Vault/1 - Rough Notes/todo.md',
			border = 'rounded',
			width = 0.65,
			height = 0.7,
		},
		keys = {
			{
				'<leader>td',
				'<cmd>TodoFloat<cr>',
				mode = 'n',
				desc = 'Toggle Floating TODO',
			},
		},
	},

	-- floterminal - custom: old nvim plugin
	{
		dir = '~/AppData/Local/nvim-backup/configs/longterm/nvim/lua/custom/plugins/floterminal.nvim/', -- Windows-only backup path
		enabled = platform.is_windows(), -- Only enable on Windows where backup exists
		opts = {},
		keys = {
			{ '<space>tt', '<CMD>Floterminal<CR>', mode = { 'n', 't' }, desc = '[T]oggle [T]erminal' },
		},
	},

	-- calendar.nvim
	{
		'itchyny/calendar.vim',
		enabled = false,
		lazy = false,
		config = function()
			vim.g.calendar_google_calendar = 1
			vim.g.calendar_google_task = 1
			vim.cmd('source ~/.cache/calendar.vim/credentials.vim')
			-- vim.cmd('source ~/.cache/calendar.vim/credentials.vim')
		end,
	},
	-- {
	-- 	dir = '~/AppData/Local/nvim/lua/plugins/calendar.nvim/',
	-- 	opts = {},
	-- },
}

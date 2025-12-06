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

	-- zen-mode - custom: old nvim-data
	{
		-- 'folke/zen-mode.nvim',
		dir = '~/AppData/Local/nvim-backup/configs/longterm/nvim-data/lazy/zen-mode.nvim/', -- Windows-only backup path
		enabled = false,
		lazy = true,
		opts = {
			window = {
				backdrop = 1,
				width = 0.70,
				height = 0.98,
				options = {
					number = false, -- disable line numbers
					relativenumber = false, -- disable relative numbers
					signcolumn = 'auto', -- disable signcolumn
					cursorline = false, -- disable cursorline
					cursorcolumn = false, -- enable cursor column
					foldcolumn = '1', -- disable fold column
					list = false, -- disable whitespace characters
				},
			},
			on_open = function()
				vim.opt.wrap = true -- enable word wrap
				vim.opt.linebreak = true -- wrap lines at word boundaries
			end,
			on_close = function()
				vim.opt.wrap = false -- disable word wrap
				vim.opt.linebreak = false -- disable linebreak
			end,
		},
		keys = {
			{ '<leader>zz', '<cmd>ZenMode<CR>', desc = 'Toggle Zen Mode' },
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

	-- hardtime - custom
	{
		'm4xshen/hardtime.nvim',
		enabled = false,
		lazy = true,
		event = 'BufReadPost',
		dependencies = { 'MunifTanjim/nui.nvim' },
		opts = {
			disable_mouse = false,
			max_count = 5,
		},
		-- config = function(_, opts)
		-- 	require('hardtime').setup()
		-- end,
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

	-- pomodoro.nvim
	{
		'quentingruber/pomodoro.nvim',
		enabled = false,
		lazy = true, -- needed so the pomodoro can start at launch
		opts = {
			start_at_launch = true,
			work_duration = 25,
			break_duration = 5,
			delay_duration = 5, -- The additionnal work time you get when you delay a break
			long_break_duration = 15,
			breaks_before_long = 4,
			display_ui_on_break = true, -- Disable it if you only want to see the lualine
		},
		keys = {
			{ '<leader>ps', '<cmp>PomodoroStart<cr>', desc = 'Start Pomodoro timer' },
			{ '<leader>po', '<cmp>PomodoroStop<cr>', desc = 'Stop Pomodoro timer' },
			{ '<leader>pu', '<cmp>PomodoroUI<cr>', desc = 'Display the Pomodoro UI' },
			{ '<leader>pk', '<cmp>PomodoroSkipBreak<cr>', desc = 'Skip the current break and start the next work session.' },
			{ '<leader>pf', '<cmp>PomodoroForceBreak<cr>', desc = '{duration?} Forcefully start a break.' },
			{ '<leader>pd', '<cmp>PomodoroDelayBreak<cr>', desc = 'Delay the current break by a delay duration.' },
		},
	},
}

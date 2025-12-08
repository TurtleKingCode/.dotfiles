return {
	-- bufferline: disabling
	{
		'akinsho/bufferline.nvim',
		enabled = false,
	},

	-- transparent.nvim (xiyaowong)
	{
		'xiyaowong/transparent.nvim',
		lazy = false,
		name = 'xiyaowong-transparent.nvim',
		enabled = true,
		-- Optional, you don't have to run setup.
		opts = {
			-- require('transparent').setup({
			-- table: default groups
            -- stylua: ignore
			groups = {
				'Normal', 'NormalNC', 'Comment', 'Constant', 'Special',
				'Identifier', 'Statement', 'PreProc', 'Type', 'Underlined',
				'Todo', 'String', 'Function', 'Conditional', 'Repeat',
				'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn',
				'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC', 'EndOfBuffer',
			},
			extra_groups = {},
			exclude_groups = {},
			on_clear = function() end,
		},
		config = function(_, opts)
			require('transparent').setup(opts)
		end,
		keys = { { '<leader>tr', '<cmd>TransparentToggle<cr>', desc = 'Toggle Transparency' } },
	},
}

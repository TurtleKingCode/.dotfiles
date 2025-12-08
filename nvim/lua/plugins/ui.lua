return {
	-- bufferline: disabling
	{
		'akinsho/bufferline.nvim',
		enabled = false,
	},

	-- transparent.nvim (xiyaowong)
	{
		'xiyaowong/transparent.nvim',
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
			-- table: additional groups that should be cleared
			extra_groups = {},
			-- table: groups you don't want to clear
			exclude_groups = {},
			-- function: code to be executed after highlight groups are cleared
			-- Also the user event "TransparentClear" will be triggered
			on_clear = function() end,
		},
		config = function(_, opts)
			require('transparent').setup(opts)
		end,
	},
}

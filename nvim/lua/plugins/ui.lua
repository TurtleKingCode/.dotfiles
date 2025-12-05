-- markview - custom
return {
	---@type LazySpec
	{
		'OXY2DEV/markview.nvim',
		enabled = false,
		lazy = true,
		event = 'VeryLazy',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-mini/mini.icons',
		},
		ft = 'markdown',
		opts = {
			preview = {
				modes = { 'n', 'i', 'no', 'c' },
				hybrid_modes = { 'i' },
				-- This is nice to have
				callbacks = {
					on_enable = function(_, win)
						vim.wo[win].conceallevel = 2
						vim.wo[win].concealcursor = 'nc'
					end,
				},
			},
		},
	},

	-- bufferline: disabling
	{
		'akinsho/bufferline.nvim',
		enabled = false,
	},

	-- transparent.nvim (tribela)
	{
		'tribela/transparent.nvim',
		name = 'tribela-transparent.nvim',
		enabled = false,
		event = 'VimEnter',
		opts = {
			auto = true,
			extra_groups = {},
			excludes = {},
		},
		-- config = true,
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

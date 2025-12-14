return {
	-- bufferline: disabling
	{ 'akinsho/bufferline.nvim', enabled = false },

	-- transparent.nvim (xiyaowong)
	{
		'xiyaowong/transparent.nvim',
		lazy = false,
		name = 'xiyaowong-transparent.nvim',
		-- Optional, you don't have to run setup.
		opts = {},
		config = function(_, opts)
			require('transparent').setup(opts)
			require('transparent').clear_prefix('lualine')
		end,
		keys = { { '<leader>tr', '<cmd>TransparentToggle<cr>', desc = 'Toggle Transparency' } },
	},
}

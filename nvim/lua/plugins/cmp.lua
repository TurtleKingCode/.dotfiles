return {
	-- catppuccin support
	{
		'catppuccin',
		optional = true,
		opts = {
			integrations = { blink_cmp = true },
		},
	},

	-- blink: harper
	{
		'saghen/blink.cmp',
		enabled = true,
		lazy = true,
		opts = {
			keymap = {
				preset = 'default',
				-- ['<CR>'] = false,
				['<Tab>'] = { 'select_and_accept' },
				['<C-y>'] = { 'select_and_accept' },
			},
		},
	},

	{
		'hrsh7th/nvim-cmp',
		lazy = true,
		dependencies = { 'hrsh7th/cmp-emoji' },
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			table.insert(opts.sources, { name = 'emoji' })
		end,
	},

	-- emoji.nvim
	{
		'allaman/emoji.nvim',
		lazy = true,
		-- enabled = false,
		-- version = '1.0.0',
		ft = 'markdown',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'hrsh7th/nvim-cmp',
			'saghen/blink.cmp',
		},
		opts = {
			enable_cmp_integration = true,
		},
		config = function(_, opts)
			require('emoji').setup(opts)
		end,
	},
	-- { 'saghen/blink.cmp', enabled = false },
}

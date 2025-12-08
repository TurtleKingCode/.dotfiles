return {
	-- catppuccin support
	{
		'catppuccin',
		optional = true,
		opts = {
			integrations = { blink_cmp = true },
		},
	},

	-- blink: emoji.nvim
	{
		'saghen/blink.cmp',
		optional = true,
		dependencies = { 'allaman/emoji.nvim', 'saghen/blink.compat' },
		opts = {
			sources = {
				default = { 'emoji' },
				providers = {
					emoji = {
						name = 'emoji',
						module = 'blink.compat.source',
						-- overwrite kind of suggestion
						transform_items = function(ctx, items)
							local kind = require('blink.cmp.types').CompletionItemKind.Text
							for i = 1, #items do
								items[i].kind = kind
							end
							return items
						end,
					},
				},
			},
			keymap = {
				preset = 'default',
				-- ['<CR>'] = false,
				['<Tab>'] = { 'select_and_accept' },
				['<C-y>'] = { 'select_and_accept' },
			},
		},
	},

	-- emoji.nvim
	{
		'allaman/emoji.nvim',
		lazy = true,
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

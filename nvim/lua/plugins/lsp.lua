return {
	-- { 'hrsh7th/nvim-cmp', enabled = true },

	-- nvim-treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		opts = {
			ensure_installed = {
				'bash',
				'html',
				'javascript',
				'json',
				'lua',
				'markdown',
				'markdown_inline',
				'python',
				'query',
				'regex',
				'tsx',
				'typescript',
				'vim',
				'yaml',
			},
		},
	},

	-- mason-lspconfig
	{
		'mason-org/mason-lspconfig.nvim',
		-- lazy = false,
		opts = {
			auto_install = true,
		},
	},
}

return {
	{
		'nvim-treesitter/nvim-treesitter',
		opts = { ensure_installed = { 'typst' } },
	},

	{
		'neovim/nvim-lspconfig',
		opts = {
			servers = {
				tinymist = {
					keys = {
						{
							'<leader>cP',
							function()
								local buf_name = vim.api.nvim_buf_get_name(0)
								local file_name = vim.fn.fnamemodify(buf_name, ':t')
								LazyVim.lsp.execute({
									command = 'tinymist.pinMain',
									arguments = { buf_name },
								})
								LazyVim.info('Tinymist: Pinned ' .. file_name)
							end,
							desc = 'Pin main file',
						},
					},
					single_file_support = true, -- Fixes LSP attachment in non-Git directories
					settings = {
						formatterMode = 'typstyle',
					},
				},
			},
		},
	},

	{
		'stevearc/conform.nvim',
		optional = true,
		opts = {
			formatters_by_ft = {
				typst = { 'typstyle', lsp_format = 'prefer' },
			},
		},
	},

	{
		'chomosuke/typst-preview.nvim',
		lazy = true,
		cmd = { 'TypstPreview', 'TypstPreviewToggle', 'TypstPreviewUpdate' },
		keys = {
			{
				'<leader>cp',
				ft = 'typst',
				'<cmd>TypstPreviewToggle<cr>',
				desc = 'Toggle Typst Preview',
			},
		},
		opts = function()
			local platform = require('config.platform')
			return {
				dependencies_bin = {
					tinymist = 'tinymist',
				},
				open_cmd = platform.get_browser_command('%s'),
			}
		end,
	},

	{
		'folke/ts-comments.nvim',
		opts = {
			lang = {
				typst = { '// %s', '/* %s */' },
			},
		},
	},
}

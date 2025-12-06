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

	-- lspconfig: harper_ls for markdown
	-- {
	-- 	'neovim/nvim-lspconfig',
	-- 	opts = {
	-- 		inlay_hints = { enabled = false },
	-- 		diagnostics = {
	-- 			float = {
	-- 				border = 'rounded',
	-- 			},
	-- 		},
	-- 		servers = {
	-- 			harper_ls = {
	-- 				enabled = true,
	-- 				filetypes = { 'markdown', 'markdown.mdx' },
	-- 				-- root_dir = function(fname)
	-- 				-- 	local lspconfig_util = require('lspconfig.util')
	-- 				-- 	local document_dir = vim.fn.expand('~/Projects/Obsidian Vault') -- Change this to your document directory
	-- 				--
	-- 				-- 	-- Check if the file is within the document directory
	-- 				-- 	if fname:find(document_dir, 1, true) == 1 then
	-- 				-- 		-- Return a root directory (can be the document dir itself or find a project root)
	-- 				-- 		return lspconfig_util.find_git_ancestor(fname) or document_dir
	-- 				-- 	end
	-- 				--
	-- 				-- 	-- Return nil to prevent LSP from starting
	-- 				-- 	return nil
	-- 				-- end,
	-- 				settings = {
	-- 					['harper-ls'] = {
	-- 						userDictPath = '~/AppData/Local/nvim/spell/en.utf-8.add',
	-- 						linters = {
	-- 							ToDoHyphen = false,
	-- 							LongSentences = false,
	-- 							-- SentenceCapitalization = true,
	-- 							-- SpellCheck = true,
	-- 						},
	-- 						markdown = {
	-- 							IgnoreLinkTitle = true,
	-- 							isolateEnglish = true,
	-- 							dialect = 'British',
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
}

return {
	-- 	'olimorris/codecompanion.nvim',
	-- 	dependencies = {
	-- 		'nvim-lua/plenary.nvim',
	-- 		'nvim-treesitter/nvim-treesitter',
	-- 	},
	-- 	opts = {
	-- 		strategies = {
	-- 			chat = { adapter = 'gemini' },
	-- 			inline = { adapter = 'gemini' },
	-- 			cmd = { adapter = 'gemini' },
	-- 		},
	-- 		opts = { log_level = 'DEBUG' },
	-- 	},
	-- 	config = function()
	-- 		require('codecompanion').setup({
	-- 			adapters = {
	-- 				gemini = function()
	-- 					return require('codecompanion.adapters').extend('gemini', {
	-- 						name = 'Gemini 2.0 Flash',
	-- 						env = { api_key = os.getenv('GEMINI_API_KEY'), },
	-- 				end,
	-- 				opts = {
	-- 					show_model_choice = true,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- 	keys = {
	-- 		{ '<leader>Ap', '<CMD>CodeCompanion<CR>', mode = { 'n', 'i' }, desc = 'CodeCompanion Prompt' },
	-- 		{ '<leader>Aa', '<CMD>CodeCompanionActions<CR>', mode = { 'n', 'i' }, desc = 'CodeCompanion Actions' },
	-- 		{ '<leader>Ac', '<CMD>CodeCompanionChat<CR>', mode = { 'n', 'i' }, desc = 'CodeCompanion Chat' },
	-- 		{ '<leader>Am', '<CMD>CodeCompanionCmd<CR>', mode = { 'n', 'i' }, desc = 'CodeCompanion Cmp' },
	-- 	},
	-- },

	-- render markdown
	{
		'MeanderingProgrammer/render-markdown.nvim',
		-- enable = false,
		opts = {
			code = {
				sign = true,
				width = 'block',
				right_pad = 1,
			},
			heading = {
				sign = true,
				-- icons = {},
			},
			checkbox = {
				enabled = true,
			},
		},
		ft = { 'markdown', 'norg', 'rmd', 'org', 'codecompanion' },
		config = function(_, opts)
			require('render-markdown').setup(opts)
			Snacks.toggle({
				name = 'Render Markdown',
				get = function()
					return require('render-markdown.state').enabled
				end,
				set = function(enabled)
					local m = require('render-markdown')
					if enabled then
						m.enable()
					else
						m.disable()
					end
				end,
			}):map('<leader>um')
		end,
	},

	-- codecompanion
	{
		'olimorris/codecompanion.nvim',
		lazy = true,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			'zbirenbaum/copilot.lua',
			-- {
			--   "github/copilot.vim",
			--   init = function() -- Only here for codecompanion to work
			--     vim.g.copilot_enabled = false
			--   end,
			-- },
		},
		opts = {},
		config = function()
			local config_opts = {
				llm = {
					-- adapter = 'copilot',
					-- adapter = 'gemini',
				},
				strategies = {
					chat = {
						adapter = 'gemini',
					},
					inline = {
						adapter = 'gemini',
					},
					cmd = {
						adapter = 'gemini',
					},
				},
				adapters = {
					gemini = function()
						return require('codecompanion.adapters').extend('gemini', {
							name = 'Gemini 2.0 Flash',
							env = { api_key = os.getenv('GEMINI_API_KEY') },
							schema = { model = { default = 'gemini-2.0-flash' } },
						})
					end,
					opts = {
						show_model_choices = true,
					},
					-- openai = function()
					-- 	return require('codecompanion.adapters').extend('openai', {
					-- 		schema = {
					-- 			model = {
					-- 				default = 'gpt-4',
					-- 			},
					-- 		},
					-- 	})
					-- end,
				},
				display = {
					chat = {
						-- intro_message = 'Welcome to CodeCompanion ✨! Press ? for options',
						show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
						separator = '─', -- The separator between the different messages in the chat buffer
						show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
						show_settings = false, -- Show LLM settings at the top of the chat buffer?
						show_token_count = true, -- Show the token count for each response?
						start_in_insert_mode = false, -- Open the chat buffer in insert mode?
					},
				},
			}
			require('codecompanion').setup(config_opts)
		end,

		keys = {
			{
				'<leader>aca',
				':CodeCompanionActions',
				desc = 'Code Companion Actions',
				mode = { 'n', 'v' },
			},
			{
				'<leader>acc',
				':CodeCompanionChat',
				desc = 'Code Companion Chat',
				mode = { 'n', 'v' },
			},
			{
				'<leader>acp',
				':CodeCompanion',
				desc = 'Code Companion Prompt',
				mode = { 'n', 'v' },
			},
			{
				'<leader>acm',
				':CodeCompanionCmd',
				desc = 'Code Companion Cmp',
				mode = { 'n', 'v' },
			},
		},
	},

	-- blink.cmp: adding codecompanion
	{
		'saghen/blink.cmp',
		opts = {
			sources = {
				per_filetype = {
					codecompanion = { 'codecompanion' },
				},
			},
		},
	},
}

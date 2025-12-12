local secrets = require('config.secrets').load_secrets()
return {
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
							env = { api_key = secrets.gemini_api_key },
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

	-- render markdown
	{ 'MeanderingProgrammer/render-markdown.nvim', ft = { 'codecompanion' } },

	-- 	-- blink.cmp: adding codecompanion
	-- 	{
	-- 		'saghen/blink.cmp',
	-- 		lazy = true,
	-- 		opts = {
	-- 			sources = {
	-- 				per_filetype = {
	-- 					codecompanion = { 'codecompanion' },
	-- 				},
	-- 			},
	-- 		},
	-- 	},

	-- gp - custom
	{
		'robitx/gp.nvim',
		lazy = false,
		enabled = true,
		config = function()
			local opts = {
				providers = {
					-- openai = { disable = true },
					copilot = {
						disable = false,
						endpoint = 'https://api.githubcopilot.com/chat/completions',
						secret = secrets.copilot_secret,
					},
				},

				-- The `providers` table configures AI completion/chat backends available to your Neovim setup.
				-- Each key under `providers` represents a provider; you can enable/disable and tweak its settings.
				--
				-- Example keys:
				--   - openai: configuration for OpenAI (currently commented out and would be disabled if enabled).
				--   - copilot: configuration for GitHub Copilot Chat.
				--
				-- copilot fields:
				--   - disable: set to `false` to enable Copilot; `true` would turn it off.
				--   - endpoint: the API base URL Copilot uses for chat/completion requests.
				--   - secret: your authentication token or a function returning it; here sourced from `secrets.copilot_secret`.
				--
				-- In practice, this tells your AI plugin to use GitHub Copilot Chat via the specified endpoint,
				-- with credentials pulled from your `secrets` module, while keeping the provider enabled.

				agents = {
					{
						provider = 'copilot',
						name = 'ChatCopilot',
						chat = true,
						command = false,
						-- string with model name or table with model name and parameters
						model = { model = 'gpt-5', temperature = 1.1, top_p = 1 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require('gp.defaults').chat_system_prompt,
					},
					{
						provider = 'copilot',
						name = 'CodeCopilot',
						chat = false,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = 'gpt-5', temperature = 0.8, top_p = 1, n = 1 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require('gp.defaults').code_system_prompt,
					},
				},
				chat_dir = vim.fn.stdpath('data'):gsub('/$', '') .. '/gp/chats',
			}

			require('gp').setup(opts)
			-- vim.api.nvim_del_user_command('GpChatFinder')
		end,

		keys = {
			-- Chat commands
			{ '<C-g>c', '<cmd>GpChatNew<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt New Chat' },
			{ '<C-g>t', '<cmd>GpChatToggle<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt Toggle Chat' },
			{ '<C-g>f', '<cmd>GpChatFinder<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt Chat Finder' },

			{ '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", mode = 'v', desc = 'Gp Prompt Visual Chat New' },
			{ '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", mode = 'v', desc = 'Gp Prompt Visual Chat Paste' },
			{ '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", mode = 'v', desc = 'Gp Prompt Visual Toggle Chat' },

			{ '<C-g><C-x>', '<cmd>GpChatNew split<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt New Chat split' },
			{ '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt New Chat vsplit' },
			{ '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt New Chat tabnew' },

			{ '<C-g><C-x>', ":<C-u>'<,'>GpChatNew split<cr>", mode = 'v', desc = 'Gp Prompt Visual Chat New split' },
			{ '<C-g><C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", mode = 'v', desc = 'Gp Prompt Visual Chat New vsplit' },
			{ '<C-g><C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", mode = 'v', desc = 'Gp Prompt Visual Chat New tabnew' },

			-- Prompt commands
			{ '<C-g>r', '<cmd>GpRewrite<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt Inline Rewrite' },
			{ '<C-g>a', '<cmd>GpAppend<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt Append (after)' },
			{ '<C-g>b', '<cmd>GpPrepend<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt Prepend (before)' },

			{ '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", mode = 'v', desc = 'Gp Prompt Visual Rewrite' },
			{ '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", mode = 'v', desc = 'Gp Prompt Visual Append (after)' },
			{ '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", mode = 'v', desc = 'Gp Prompt Visual Prepend (before)' },
			{ '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", mode = 'v', desc = 'Gp Prompt Implement selection' },

			{ '<C-g>gp', '<cmd>GpPopup<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt Popup' },
			{ '<C-g>ge', '<cmd>GpEnew<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt GpEnew' },
			{ '<C-g>gn', '<cmd>GpNew<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt GpNew' },
			{ '<C-g>gv', '<cmd>GpVnew<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt GpVnew' },
			{ '<C-g>gt', '<cmd>GpTabnew<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt GpTabnew' },

			{ '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", mode = 'v', desc = 'Gp Prompt Visual Popup' },
			{ '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", mode = 'v', desc = 'Gp Prompt Visual GpEnew' },
			{ '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", mode = 'v', desc = 'Gp Prompt Visual GpNew' },
			{ '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", mode = 'v', desc = 'Gp Prompt Visual GpVnew' },
			{ '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", mode = 'v', desc = 'Gp Prompt Visual GpTabnew' },

			{ '<C-g>x', '<cmd>GpContext<cr>', mode = { 'n', 'i' }, desc = 'Gp Prompt Toggle Context' },
			{ '<C-g>x', ":<C-u>'<,'>GpContext<cr>", mode = 'v', desc = 'Gp Prompt Visual Toggle Context' },

			{ '<C-g>s', '<cmd>GpStop<cr>', mode = { 'n', 'i', 'v', 'x' }, desc = 'Gp Prompt Stop' },
			{ '<C-g>n', '<cmd>GpNextAgent<cr>', mode = { 'n', 'i', 'v', 'x' }, desc = 'Gp Prompt Next Agent' },
		},
	},

	-- avante
	{
		'yetone/avante.nvim',
		enabled = false,
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		-- ⚠️ must add this setting! ! !
		build = vim.fn.has('win32') ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
		event = 'VeryLazy',
		version = false, -- Never set this value to "*"! Never!
		---@module 'avante'
		---@type avante.Config
		opts = {
			-- add any opts here
			-- this file can contain specific instructions for your project
			instructions_file = 'avante.md',
			-- for example
			provider = 'claude',
			providers = {
				claude = {
					endpoint = 'https://api.anthropic.com',
					model = 'claude-sonnet-4-20250514',
					timeout = 30000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
				},
				moonshot = {
					endpoint = 'https://api.moonshot.ai/v1',
					model = 'kimi-k2-0711-preview',
					timeout = 30000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 32768,
					},
				},
			},
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
			--- The below dependencies are optional,
			'nvim-mini/mini.pick', -- for file_selector provider mini.pick
			'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
			'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
			'ibhagwan/fzf-lua', -- for file_selector provider fzf
			'stevearc/dressing.nvim', -- for input provider dressing
			'folke/snacks.nvim', -- for input provider snacks
			'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
			'zbirenbaum/copilot.lua', -- for providers='copilot'
			{
				-- support for image pasting
				'HakonHarnes/img-clip.nvim',
				event = 'VeryLazy',
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { 'markdown', 'Avante' },
				},
				ft = { 'markdown', 'Avante' },
			},
		},
	},
	{
		'zbirenbaum/copilot.lua',
		dependencies = {
			'copilotlsp-nvim/copilot-lsp',
		},
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup({})
		end,
	},
}

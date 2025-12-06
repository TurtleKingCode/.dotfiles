return {
	{
		-- gp - custom: old nvim-data
		'robitx/gp.nvim',
		-- dir = '~/AppData/Local/nvim-backup/configs/longterm/nvim-data/lazy/gp.nvim/',
		-- enabled = false,
		-- name = 'my-gp',
		lazy = true,
		config = function()
			local opts = {
				providers = {
					googleai = {
						disable = false,
						endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}',
						secret = os.getenv('GEMINI_API_KEY'),
						model = 'gemini-2.5-flash',
					},
					openai = {
						disable = true,
						endpoint = 'https://api.openai.com/v1/chat/completions',
						secret = os.getenv('OPENAI_SECRET'),
					},
				},
				agents = {
					-- They don't need to be explicity disabled because the original provider is disabled
					-- { name = 'ChatGPT-o3-mini', disable = true },
					-- { name = 'ChatGPT4o', disable = true },
					-- { name = 'ChatGPT4o-mini', disable = true },
					{
						provider = 'googleai',
						name = 'ChatGemini',
						chat = true,
						command = false,
						-- string with model name or table with model name and parameters
						model = { model = 'gemini-2.5-flash' },
						system_prompt = require('gp.defaults').chat_system_prompt,
					},
					{
						provider = 'googleai',
						name = 'CodeGemini',
						chat = false,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = 'gemini-2.0-flash-lite' },
						system_prompt = 'Answer my questions and complete any tasks I give you with brevity.',
						-- system_prompt = require('gp.defaults').code_system_prompt,
					},
					{
						provider = 'googleai',
						name = 'GeneralGemini',
						chat = true,
						command = false,
						-- string with model name or table with model name and parameters
						model = { model = 'gemini-2.5-flash' },
						system_prompt = 'Answer my questions',
					},
					-- 	{
					-- 		name = 'GoogleAI',
					-- 		disable = false,
					-- 		provider = 'googleai',
					-- 		chat = true,
					-- 		command = true,
					-- 		model = { model = 'gemini-2.5-flash' },
					-- 		system_prompt = 'Answer my questions conncisely and accurately. If you do not know the answer, say "I do not know".',
					-- 	},
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
}

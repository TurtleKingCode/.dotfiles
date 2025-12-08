return {
	-- flash
	{ 'folke/flash.nvim', enabled = false },

	-- oil - custom
	{
		'stevearc/oil.nvim',
		event = 'VimEnter',
		-- event = 'VeryLazy',
		lazy = false,
		opts = {},
		-- dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
		keys = { { '-', '<cmd>Oil --float<cr>', desc = 'Open root dir' } },
		config = function()
			require('oil').setup({
				default_file_explorer = true,
				keymaps = {
					['-'] = { 'actions.close', mode = 'n' },
					['<Esc>'] = { 'actions.close', mode = 'n' },
					['q'] = { 'actions.close', mode = 'n' },
					['<C-c>'] = { 'actions.parent', mode = 'n' },
					['<BS>'] = { 'actions.parent', mode = 'n' },
				},
				float = {
					padding = 2,
				},
				-- columns = {
				-- 	'icon',
				-- 	'filename',
				-- 	'size',
				-- 	'mtime',
				-- },
				preview_win = {
					update_on_cursor_moved = true,
					preview_method = 'fast_scratch',
					win_options = {},
				},
			})
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			vim.api.nvim_create_autocmd('User', {
				pattern = 'OilEnter',
				callback = vim.schedule_wrap(function(args)
					local oil = require('oil')
					if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
						oil.open_preview()
					end
				end),
			})
		end,
	},

	-- markdown-preview - custom
	{
		'iamcco/markdown-preview.nvim',
		build = 'cd app ; npm install',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		lazy = true,

		config = function()
			vim.cmd([[do FileType]])
		end,

		keys = {
			{
				'<leader>cp',
				ft = 'markdown',
				'<cmd>MarkdownPreviewToggle<cr>',
				desc = 'Markdown Preview',
			},
		},

		init = function()
			vim.g.mkdp_filetypes = { 'markdown' }
			vim.g.mkdp_command_for_global = 1
			vim.g.mkdp_browser = 'msedge'
			-- vim.g.mkdp_browser = '~\\AppData\\Local\\imput\\Helium\\Application\\chrome.exe'
			vim.g.mkdp_combine_preview = 1
		end,
	},

	-- obsidian.nvim
	{
		'epwalsh/obsidian.nvim',
		enabled = false,
		version = '*',
		lazy = true,
		event = {
			'BufReadPre ~/Projects/Obsidian Vault/*.md',
			'BufNewFile ~/Projects/Obsidian Vault/*.md',
		},
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			workspaces = {
				{
					name = 'Obsidian-Vault',
					path = '~/Projects/Obsidian Vault/',
				},
			},
		},
		keys = {
			{
				'<leader>on',
				'<cmd>ObsidianNew<cr>',
				desc = 'Create Obsdidian Note',
			},
			{
				'<leader>oo',
				'<cmd>ObsidianOpen',
				desc = 'Open Obsdidian Note',
			},
			{
				'<leader>off',
				'<cmd>ObsidianFollowLink<cr>',
				desc = 'Follow Obsidian Link',
			},
			{
				'<leader>ofv',
				'<cmd>ObsidianFollowLink vsplit<cr>',
				desc = 'Follow Obsidian Link (vsplit)',
			},
			{
				'<leader>ofh',
				'<cmd>ObsidianFollowLink hsplit<cr>',
				desc = 'Follow Obsidian Link (hsplit)',
			},
		},
	},

	-- checkmate
	---@type checkmate.Config
	{
		'bngarren/checkmate.nvim',
		lazy = true,
		ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
		opts = {
			enabled = true,
			notify = true,
			-- Default file matching:
			--  - Any `todo` or `TODO` file, including with `.md` extension
			--  - Any `.todo` extension (can be ".todo" or ".todo.md")
			-- To activate Checkmate, the filename must match AND the filetype must be "markdown"
			files = {
				'todo',
				'TODO',
				'todo.md',
				'TODO.md',
				'*.todo',
				'*.todo.md',
			},
			log = {
				level = 'warn',
				use_file = true,
			},
			-- Default keymappings
			keys = {
				['<leader>t<Enter>'] = {
					rhs = '<cmd>Checkmate toggle<CR>',
					desc = 'Toggle todo item',
					modes = { 'n', 'v' },
				},
				['<leader>Tc'] = {
					rhs = '<cmd>Checkmate check<CR>',
					desc = 'Set todo item as checked (done)',
					modes = { 'n', 'v' },
				},
				['<leader>tu'] = {
					rhs = '<cmd>Checkmate uncheck<CR>',
					desc = 'Set todo item as unchecked (not done)',
					modes = { 'n', 'v' },
				},
				['<leader>t='] = {
					rhs = '<cmd>Checkmate cycle_next<CR>',
					desc = 'Cycle todo item(s) to the next state',
					modes = { 'n', 'v' },
				},
				['<leader>t-'] = {
					rhs = '<cmd>Checkmate cycle_previous<CR>',
					desc = 'Cycle todo item(s) to the previous state',
					modes = { 'n', 'v' },
				},
				['<leader>tn'] = {
					rhs = '<cmd>Checkmate create<CR>',
					desc = 'Create todo item',
					modes = { 'n', 'v' },
				},
				['<leader>tr'] = {
					rhs = '<cmd>Checkmate remove<CR>',
					desc = 'Remove todo marker (convert to text)',
					modes = { 'n', 'v' },
				},
				['<leader>tR'] = {
					rhs = '<cmd>Checkmate remove_all_metadata<CR>',
					desc = 'Remove all metadata from a todo item',
					modes = { 'n', 'v' },
				},
				['<leader>ta'] = {
					rhs = '<cmd>Checkmate archive<CR>',
					desc = 'Archive checked/completed todo items (move to bottom section)',
					modes = { 'n' },
				},
				['<leader>tv'] = {
					rhs = '<cmd>Checkmate metadata select_value<CR>',
					desc = 'Update the value of a metadata tag under the cursor',
					modes = { 'n' },
				},
				['<leader>t]'] = {
					rhs = '<cmd>Checkmate metadata jump_next<CR>',
					desc = 'Move cursor to next metadata tag',
					modes = { 'n' },
				},
				['<leader>t['] = {
					rhs = '<cmd>Checkmate metadata jump_previous<CR>',
					desc = 'Move cursor to previous metadata tag',
					modes = { 'n' },
				},
			},
			default_list_marker = '-',
			todo_states = {
				-- we don't need to set the `markdown` field for `unchecked` and `checked` as these can't be overriden
				---@diagnostic disable-next-line: missing-fields
				unchecked = {
					marker = '[ ]',
					order = 1,
				},
				---@diagnostic disable-next-line: missing-fields
				checked = {
					marker = '[x]',
					order = 2,
				},
			},
			style = {}, -- override defaults
			enter_insert_after_new = true, -- Should enter INSERT mode after `:Checkmate create` (new todo)
			list_continuation = {
				enabled = true,
				split_line = true,
				keys = {
					['<CR>'] = function()
						require('checkmate').create({
							position = 'below',
							indent = false,
						})
					end,
					['<S-CR>'] = function()
						require('checkmate').create({
							position = 'below',
							indent = true,
						})
					end,
				},
			},
			smart_toggle = {
				enabled = true,
				include_cycle = false,
				check_down = 'direct_children',
				uncheck_down = 'none',
				check_up = 'direct_children',
				uncheck_up = 'direct_children',
			},
			show_todo_count = true,
			todo_count_position = 'eol',
			todo_count_recursive = true,
			use_metadata_keymaps = true,
			metadata = {
				-- Example: A @priority tag that has dynamic color based on the priority value
				priority = {
					style = function(context)
						local value = context.value:lower()
						if value == 'high' then
							return { fg = '#ff5555', bold = true }
						elseif value == 'medium' then
							return { fg = '#ffb86c' }
						elseif value == 'low' then
							return { fg = '#8be9fd' }
						else -- fallback
							return { fg = '#8be9fd' }
						end
					end,
					get_value = function()
						return 'medium' -- Default priority
					end,
					choices = function()
						return { 'low', 'medium', 'high' }
					end,
					key = '<leader>tp',
					sort_order = 10,
					jump_to_on_insert = 'value',
					select_on_insert = true,
				},
				-- Example: A @started tag that uses a default date/time string when added
				started = {
					aliases = { 'init' },
					style = { fg = '#9fd6d5' },
					get_value = function()
						return tostring(os.date('%m/%d/%y %H:%M'))
					end,
					key = '<leader>ts',
					sort_order = 20,
				},
				-- Example: A @done tag that also sets the todo item state when it is added and removed
				done = {
					aliases = { 'completed', 'finished' },
					style = { fg = '#96de7a' },
					get_value = function()
						return tostring(os.date('%m/%d/%y %H:%M'))
					end,
					key = '<leader>td',
					on_add = function(todo_item)
						require('checkmate').set_todo_item(todo_item, 'checked')
					end,
					on_remove = function(todo_item)
						require('checkmate').set_todo_item(todo_item, 'unchecked')
					end,
					sort_order = 30,
				},
				due = {
					get_value = function()
						return tostring(os.date('%m/%d/%y'))
					end,
					key = '<leader>ue',
					style = { fg = '#f57327', bold = true },
				},
			},
			archive = {
				heading = {
					title = 'Archive',
					level = 2, -- e.g. ##
				},
				parent_spacing = 0, -- no extra lines between archived todos
				newest_first = true,
			},
			linter = {
				enabled = true,
			},
		},
	},

	-- vim-pencil
	{
		'preservim/vim-pencil',
		init = function()
			vim.g['pencil#wrapModeDefault'] = 'soft'
		end,
	},
}

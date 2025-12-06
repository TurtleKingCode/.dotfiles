return {
	-- flash
	{ 'folke/flash.nvim', enabled = false },

	-- oil - custom
	{
		'stevearc/oil.nvim',
		lazy = true,
		event = 'VeryLazy',
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
					-- Whether the preview window is automatically updated when the cursor is moved
					update_on_cursor_moved = true,
					-- How to open the preview window "load"|"scratch"|"fast_scratch"
					preview_method = 'fast_scratch',
					-- Window-local options to use for preview window buffers
					win_options = {},
				},
			})
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			-- oil.open_prev_when_open = function()
			-- 	-- local oil = require('oil')
			-- 	if oil.get_cursor_entry() then
			-- 		oil.open_preview()
			-- 	end
			-- end

			-- vim.api.nvim_create_user_command('Ex', function()
			-- 	require('oil').open_float()
			-- end, {})

			-- local open_preview = function()
			-- 	local oil = require('oil')
			-- 	if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
			-- 		oil.open_preview()
			-- 	end
			-- end

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

	-- markdown-preview - custom: old nvim-data
	{
		-- 'iamcco/markdown-preview.nvim',
		dir = '~/AppData/Local/nvim-backup/configs/longterm/nvim-data/lazy/markdown-preview.nvim/', -- Windows-only backup path
		enabled = false,
		name = 'my-markdown-preview',
		lazy = true,
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		ft = 'markdown',
		-- build = 'cd app ; npm install',
		init = function()
			vim.g.mkdp_filetypes = { 'markdown' }
			vim.g.mkdp_command_for_global = 1
			vim.g.mkdp_browser = 'zen'
			vim.g.mkdp_combine_preview = 1
		end,
	},

	-- markdown-preview - custom
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		config = function()
			vim.cmd([[do FileType]])
		end,
		build = 'cd app ; npm install',

		-- build = function()
		-- 	vim.cmd('source ./mkdp/util/install.vim')
		-- 	-- require('mkdp.util').install()
		-- end,
		-- build = function()
		-- 	require('lazy').load({ plugins = { 'markdown-preview.nvim' } })
		-- 	vim.fn['mkdp#util#install']()
		-- end,
		-- build = function()
		-- 	require('lazy').load({ plugins = { 'markdown-preview.nvim' } })
		-- 	local plugin_path = vim.fn.expand('$HOME/AppData/Local/nvim-data/lazy/markdown-preview.nvim')
		-- 	local install_cmd = '"' .. plugin_path .. '/app/install.cmd"'
		-- 	vim.fn.system(install_cmd)
		-- end,

		lazy = true,
		ft = 'markdown',
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

	-- harpoon - custom: old nvim-data
	{
		-- 'ThePrimeagen/harpoon',
		dir = '~/AppData/Local/nvim-backup/configs/longterm/nvim-data/lazy/harpoon/', -- Windows-only backup path
		enabled = false,
		name = 'my-harpoon',
		branch = 'harpoon2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		lazy = true,
		keys = function()
			local keys = {
				{
					'<leader>A',
					function()
						require('harpoon'):list():add()
					end,
					desc = 'harpoon file',
				},
				{
					'<leader>a',
					function()
						local harpoon = require('harpoon')
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = 'harpoon quick menu',
				},
			}

			-- for i = 1, 5 do
			for i, j in pairs({ 'j', 'i', 'o', ';', "'" }) do
				table.insert(keys, {
					'<leader>' .. j,
					function()
						require('harpoon'):list():select(i)
					end,
					desc = 'Harpoon to File ' .. i,
				})
			end

			return keys
		end,
		-- config = Config
	},

	-- yazi
	---@type LazySpec
	{
		'mikavilpas/yazi.nvim',
		enabled = false,
		event = 'VeryLazy',
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				'<leader>=',
				mode = { 'n', 'v' },
				'<cmd>Yazi<cr>',
				desc = 'Open yazi at the current file',
			},
			{
				-- Open in the current working directory
				'<leader>cw',
				'<cmd>Yazi cwd<cr>',
				desc = "Open the file manager in nvim's working directory",
			},
			{
				'<c-up>',
				'<cmd>Yazi toggle<cr>',
				desc = 'Resume the last yazi session',
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
			keymaps = {
				show_help = '<f1>',
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			-- vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},

	-- mkdnflow
	{

		'jakewvincent/mkdnflow.nvim',
		enabled = false,
		config = function()
			require('mkdnflow').setup({})
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

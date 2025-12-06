return {
	{
		'snacks.nvim',
		opts = {
			indent = { enabled = false },
			input = { enabled = false },
			notifier = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false }, -- we set this in options.lua
			toggle = { map = LazyVim.safe_keymap_set },
			words = { enabled = false },
		},
	},
	-- snacks.nvim - zen
	{
		'folke/snacks.nvim',
		---@type snacks.Config
		opts = {
			zen = {
				window = {
					backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
					width = 80, -- width of the Zen window
					height = 1, -- height of the Zen window
					-- by default, no options are changed for the Zen window
					-- uncomment any of the options below, or add other vim.wo options you want to apply
					options = {
						-- signcolumn = "no", -- disable signcolumn
						number = false, -- disable number column
						-- relativenumber = false, -- disable relative numbers
						-- cursorline = false, -- disable cursorline
						-- cursorcolumn = false, -- disable cursor column
						-- foldcolumn = "0", -- disable fold column
						-- list = false, -- disable whitespace characters
					},
				},
				plugins = {
					-- disable some global vim options (vim.o...)
					-- comment the lines to not apply the options
					options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
						-- you may turn on/off statusline in zen mode by setting 'laststatus'
						-- statusline will be shown only if 'laststatus' == 3
						laststatus = 0, -- turn off the statusline in zen mode
					},
					gitsigns = { enabled = false }, -- disables git signs
				},
			},
		},
	},

	-- snacks.nvim - style: for zen
	{
		'snacks.nvim',
		---@type snacks.Config
		opts = {
			---@class snacks.zen.Config
			zen = {
				toggles = {
					dim = false,
					git_signs = false,
					mini_diff_signs = false,
					diagnostics = false,
					inlay_hints = false,
				},
				show = { tabline = false },
				on_open = function()
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false

					if vim.bo.filetype == 'markdown' then
						vim.opt_local.wrap = true
						vim.opt_local.linebreak = true
					end
				end,

				on_close = function()
					vim.opt_local.number = true
					vim.opt_local.relativenumber = true

					if vim.bo.filetype == 'markdown' then
						vim.opt_local.wrap = true
						vim.opt_local.linebreak = true
					else
						vim.opt_local.wrap = false
						vim.opt_local.linebreak = false
						vim.opt_local.spell = false
					end
				end,
			},

			---@class snacks.styles.Config
			styles = {
				zen = {
					backdrop = { transparent = false, blend = 99 },
					width = 0.7,
					keys = { q = false },
				},
			},
		},
	},

	-- snacks.nvim - dashboard: Header Page
	{
		'snacks.nvim',
		opts = {
			dashboard = {
				preset = {
					pick = function(cmd, opts)
						return LazyVim.pick(cmd, opts)()
					end,
					header = [[

████████╗██╗   ██╗██████╗ ████████╗██╗     ███████╗██╗   ██╗██╗███╗   ███╗
╚══██╔══╝██║   ██║██╔══██╗╚══██╔══╝██║     ██╔════╝██║   ██║██║████╗ ████║
   ██║   ██║   ██║██████╔╝   ██║   ██║     █████╗  ╚██╗ ██╔╝██║██╔████╔██║
   ██║   ██║   ██║██╔══██╗   ██║   ██║     ██╔══╝   ╚████╔╝ ██║██║╚██╔╝██║
   ██║   ╚██████╔╝██║  ██║   ██║   ███████╗███████╗  ╚██╔╝  ██║██║ ╚═╝ ██║
   ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝   ╚═╝   ╚═╝╚═╝     ╚═╝
					]],
   -- 		header = [[
   --  ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
   --  ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
   --  ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
   --  ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
   --  ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
   --  ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
   -- ]],
					-- stylua: ignore
					---@type snacks.dashboard.Item[]
					keys = {
						{ icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = '󰧑 ', key = 'o', desc = 'Obsidian Vault', action = ":lua Snacks.dashboard.pick('files', {cwd = '~/Projects/Obsidian Vault'})", },
						{ icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
						{ icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
						{ icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
						{ icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
						{ icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
						{ icon = ' ', key = 'x', desc = 'Lazy Extras', action = ':LazyExtras' },
						{ icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
						{ icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
					},
				},
			},
		},
	},
}

local state = require('config.state')

return {
	-- colorscheme
	{
		'LazyVim/LazyVim',
		opts = {
			-- colorscheme = 'rose-pine',
			-- colorscheme = 'cyberdream',
			-- colorscheme = 'tokyodark',
			-- colorscheme = 'gruvbox',
			colorscheme = state.colorscheme or 'rose-pine',
		},
	},

	-- rosé-pine
	{
		'rose-pine/neovim',
		lazy = true,
		name = 'rosé-pine',
		-- opts = {
		-- 	variant = 'main',
		-- 	dim_inactive_windows = true,
		-- 	extend_background_behind_borders = true,
		-- 	styles = { transparency = false },
		-- },
		opts = {
			-- variant = 'main', -- turned off so ligt and dakr can work
			dark_variant = 'main',
			light_varient = 'dawn',
			dim_inactive_windows = false,
			extend_background_behind_borders = true,
			enable = {
				terminal = true,
				legacy_highlights = true,
				migrations = true,
			},
			styles = { transparency = false },
			palette = {
				main = {
					base = '#000000',
					surface = '#000000',
					overlay = '#000000',
				},
			},
		},
		config = function(_, opts)
			require('rose-pine').setup(opts)
		end,
	},

	-- cyberdream
	{ 'scottmckendry/cyberdream.nvim', lazy = true, opts = { transparent = false } },

	-- oldworld
	{ 'dgox16/oldworld.nvim', lazy = true },

	-- onedarkpro
	{ 'olimorris/onedarkpro.nvim', lazy = true },

	-- bamboo
	{
		'ribru17/bamboo.nvim',
		lazy = true,
		opts = {},
		config = function(_, opts)
			require('bamboo').setup(opts)
		end,
	},

	{
		'tiagovla/tokyodark.nvim',
		lazy = true,
		opts = {},
		config = function(_, opts)
			require('tokyodark').setup(opts) -- calling setup is optional
		end,
	},
	{ 'ellisonleao/gruvbox.nvim', lazy = true },

	-- everforest-nvim
	{
		'neanias/everforest-nvim',
		lazy = false,
		priority = 90, -- make sure to load this before all the other start plugins
		opt = {
			background = 'medium',
			transparent_background_level = 0,
			italics = true,
			disable_italic_comments = false,
			inlay_hints_background = 'dimmed',
			on_highlights = function(hl, palette)
				hl['@string.special.symbol.ruby'] = { link = '@field' }
				hl['DiagnosticUnderlineWarn'] = { undercurl = true, sp = palette.yellow }
			end,
		},
		config = function(_, opts)
			require('everforest').setup(opts)
		end,
	},
	{
		'Rigellute/shades-of-purple.vim',
		init = function()
			vim.g.shades_of_purple_airline = 1
			vim.g.airline_theme = 'shades_of_purple'
			-- vim.g.shades_of_purple_lightline = 1
			-- vim.g.lightline = { colorscheme = 'shades_of_purple' }
			-- vim.g.shades_of_purple_transparent_bg = 1
		end,
	},
}

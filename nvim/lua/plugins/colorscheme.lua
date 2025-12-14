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

	-- everforest
	{
		'sainnhe/everforest',
		lazy = true,
		config = function()
			vim.g.everforest_enable_italic = true
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
}

local function get_wordcount()
	local word_count = 0

	if vim.fn.mode():find('[vV]') then
		word_count = vim.fn.wordcount().visual_words
	else
		word_count = vim.fn.wordcount().words
	end

	return word_count
end

local function count_and_time()
	-- creating wordcount part
	local label = 'word'
	local word_count = get_wordcount()
	if word_count > 1 then
		label = label .. 's'
	end
	local wordcount = word_count .. ' ' .. label

	-- create reading_time part
	local reading_time = tostring(math.ceil(get_wordcount() / 200.0)) .. ' min'

	return wordcount .. ' | ' .. reading_time
end

local function is_prose()
	return vim.bo.filetype == 'markdown' or vim.bo.filetype == 'text'
end

return {
	'nvim-lualine/lualine.nvim',
	event = 'VeryLazy',
	dependencies = {
		-- {
		-- 	'justinhj/battery.nvim',
		-- 	config = function()
		-- 		local battery = require('battery')
		-- 		battery.setup({
		-- 			update_rate_seconds = 300, -- Number of seconds between checking battery status
		-- 			show_status_when_no_battery = true, -- Don't show any icon or text when no battery found (desktop for example)
		-- 			show_plugged_icon = false, -- If true show a cable icon alongside the battery icon when plugged in
		-- 			show_unplugged_icon = false, -- When true show a diconnected cable icon when not plugged in
		-- 			show_percent = true, -- Whether or not to show the percent charge remaining in digits
		-- 			vertical_icons = true, -- When true icons are vertical, otherwise shows horizontal battery icon
		-- 			multiple_battery_selection = 1, -- Which battery to choose when multiple found. "max" or "maximum", "min" or "minimum" or a number to pick the nth battery found (currently linux acpi only)
		-- 		})
		-- 	end,
		-- },
	},
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = ' '
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		-- PERF: we don't need this lualine require madness 🤷
		local lualine_require = require('lualine_require')
		lualine_require.require = require

		local icons = LazyVim.config.icons

		vim.o.laststatus = vim.g.lualine_laststatus

		local opts = {
			options = {
				theme = 'auto',
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch' },

				lualine_c = {
					LazyVim.lualine.root_dir(),
					{
						'diagnostics',
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
					{ 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
					{ LazyVim.lualine.pretty_path() },
				},
				lualine_x = {
					Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
					{
						'diff',
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},
				lualine_y = {
					{ count_and_time, cond = is_prose },
					{ 'progress', separator = ' ', padding = { left = 1, right = 0 } },
					{ 'location', padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						-- return " " .. os.date("%R")
						return os.date('%b %d - %R')
						-- return os.date('%B %d - %R')
					end,
				},
			},
			extensions = { 'neo-tree', 'lazy', 'fzf' },
		}

		-- do not add trouble symbols if aerial is enabled
		-- And allow it to be overriden for some buffer types (see autocmds)
		if vim.g.trouble_lualine and LazyVim.has('trouble.nvim') then
			local trouble = require('trouble')
			local symbols = trouble.statusline({
				mode = 'symbols',
				groups = {},
				title = false,
				filter = { range = true },
				format = '{kind_icon}{symbol.name:Normal}',
				hl_group = 'lualine_c_normal',
			})
			table.insert(opts.sections.lualine_c, {
				symbols and symbols.get,
				cond = function()
					return vim.b.trouble_lualine ~= false and symbols.has()
				end,
			})
		end

		return opts
	end,
}

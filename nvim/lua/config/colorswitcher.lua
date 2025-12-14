local function persist_to_file(scheme)
	if not scheme or scheme == "" then
		return false, "no colorscheme name provided"
	end

	local config_dir = vim.fn.stdpath("config")
	local dir = config_dir .. "/lua/config"
	local color_file = dir .. "/color.lua"

	local content = "return { colorscheme = '" .. scheme .. "' }\n"

	local ok, err = pcall(function()
		vim.fn.mkdir(dir, "p")
		vim.fn.writefile({ content }, color_file)
	end)

	if not ok then
		return false, "Failed to write to " .. color_file .. ": " .. tostring(err)
	end

	return true, color_file
end

-- vim.api.nvim_create_augroup("auto_persist_colorscheme", { clear = true })
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   group = "AutoPersistColorScheme",
--   callback = function()
--     local scheme = vim.g.colors_name
--     if not scheme or scheme == "" then
--       -- Some schemes briefly unset colors_name; guard against that.
--       return
--     end
--     local ok, info = persist_to_file(scheme)
--     if not ok then
--       vim.notify(info, vim.log.levels.ERROR)
--     else
--       -- Comment the next line if you prefer quiet behavior.
--       vim.notify("Colorscheme saved: " .. scheme, vim.log.levels.INFO)
--     end
--   end,
--   -- Optional: If you want to restrict to certain filetypes or only after startup, adjust pattern/event.
-- })

local function callback()
	print('callback')
	local scheme = vim.g.colors_name
	if not scheme or scheme == "" then
		-- Some schemes briefly unset colors_name; guard against that.
		return
	end
	local ok, info = persist_to_file(scheme)
	if not ok then
		vim.notify(info, vim.log.levels.ERROR)
	else
		-- Comment the next line if you prefer quiet behavior.
		vim.notify("Colorscheme saved: " .. scheme, vim.log.levels.INFO)
	end
end

callback()

return callback

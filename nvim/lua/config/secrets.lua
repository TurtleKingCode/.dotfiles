-- Utility function to load secrets from .private/secrets.lua
local M = {}

function M.load_secrets()
	local config_path = vim.fn.stdpath('config')
	local secrets_path = config_path .. '/.private/secrets.lua'
	
	-- Check if secrets file exists
	if vim.fn.filereadable(secrets_path) == 0 then
		vim.notify(
			'Secrets file not found at ' .. secrets_path,
			vim.log.levels.WARN
		)
		return {}
	end
	
	-- Load the secrets file
	local ok, secrets = pcall(dofile, secrets_path)
	if not ok then
		vim.notify(
			'Failed to load secrets file: ' .. tostring(secrets),
			vim.log.levels.ERROR
		)
		return {}
	end
	
	return secrets or {}
end

-- return M
return {}
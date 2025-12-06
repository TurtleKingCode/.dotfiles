-- Platform detection utility for cross-platform Neovim configuration
local M = {}

-- Detect operating system
function M.is_windows()
	return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

function M.is_linux()
	return vim.fn.has('unix') == 1 and not vim.fn.has('mac') == 1
end

function M.is_mac()
	return vim.fn.has('mac') == 1
end

function M.os_name()
	if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
		return 'windows'
	elseif vim.fn.has('mac') == 1 then
		return 'macos'
	else
		return 'linux'
	end
end

-- Get platform-appropriate paths
function M.get_config_dir()
	if M.is_windows() then
		return vim.fn.expand('~/AppData/Local/nvim')
	else
		return vim.fn.expand('~/.config/nvim')
	end
end

function M.get_data_dir()
	if M.is_windows() then
		return vim.fn.expand('~/AppData/Local/nvim-data')
	else
		return vim.fn.expand('~/.local/share/nvim')
	end
end

function M.get_backup_dir()
	if M.is_windows() then
		return vim.fn.expand('~/AppData/Local/nvim-backup/configs/longterm')
	else
		-- On Linux, return nil or a different path if you want to support this
		return nil
	end
end

-- Get platform-appropriate shell configuration
function M.get_shell_config()
	if M.is_windows() then
		return {
			shell = 'pwsh',
			shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command',
			shellxquote = '',
		}
	else
		-- Use default shell on Linux/Mac (usually bash or sh)
		return {
			shell = vim.o.shell, -- Keep system default
			shellcmdflag = vim.o.shellcmdflag,
			shellxquote = vim.o.shellxquote,
		}
	end
end

-- Get platform-appropriate date command
function M.get_date_command()
	if M.is_windows() then
		return 'powershell -Command "Get-Date"'
	else
		return 'date'
	end
end

-- Get platform-appropriate browser open command
function M.get_browser_command(url)
	if M.is_windows() then
		return 'start chrome ' .. (url or '%s')
	elseif M.is_mac() then
		return 'open ' .. (url or '%s')
	else
		-- Linux
		return 'xdg-open ' .. (url or '%s')
	end
end

-- Get platform-appropriate spell dictionary path
function M.get_spell_path()
	if M.is_windows() then
		return vim.fn.expand('~/AppData/Local/nvim/spell/en.utf-8.add')
	else
		return vim.fn.expand('~/.config/nvim/spell/en.utf-8.add')
	end
end

return M

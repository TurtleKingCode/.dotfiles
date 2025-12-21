# WindowsPowershell v5.1
Set-Alias winfetch pwshfetch-test-1
#C:\Users\HOME\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

$userProfile = [Environment]::GetFolderPath('UserProfile')

# Requires -Modules PSReadLine


# Set-Alias to create the 'f' alias
#Set-Alias -Name f -Value f

function fim {
    param(
        [string]$Pattern = ""
    )

    function Show-Menu {
        param(
            [array]$Items,
            [string]$Prompt = "Select file"
        )
        
        if ($Items.Count -eq 0) {
            Write-Host "No files found." -ForegroundColor Yellow
            return $null
        }
        
        if ($Items.Count -eq 1) {
            return $Items[0]
        }
        
        $selected = 0
        $query = ""
        $filteredItems = $Items
        
        # Hide cursor
        [Console]::CursorVisible = $false
        
        try {
            while ($true) {
                Clear-Host
                Write-Host "$Prompt ($($filteredItems.Count) files)" -ForegroundColor Cyan
                Write-Host "Query: $query" -ForegroundColor Gray
                Write-Host "Use arrows, type to filter, Enter to select, Esc to cancel" -ForegroundColor DarkGray
                Write-Host ""
                
                # Show filtered items
                $displayCount = [Math]::Min($filteredItems.Count, 20)
                for ($i = 0; $i -lt $displayCount; $i++) {
                    $item = $filteredItems[$i]
                    if ($i -eq $selected) {
                        Write-Host "> $item" -ForegroundColor Green -BackgroundColor DarkGreen
                    } else {
                        Write-Host "  $item" -ForegroundColor White
                    }
                }
                
                if ($filteredItems.Count -gt 20) {
                    Write-Host "  ... and $($filteredItems.Count - 20) more" -ForegroundColor DarkGray
                }
                
                $key = [Console]::ReadKey($true)
                
                switch ($key.Key) {
                    'Enter' { 
                        if ($filteredItems.Count -gt 0) {
                            return $filteredItems[$selected]
                        }
                    }
                    'Escape' { 
                        return $null 
                    }
                    'UpArrow' { 
                        if ($selected -gt 0) { 
                            $selected-- 
                        }
                    }
                    'DownArrow' { 
                        if ($selected -lt ($filteredItems.Count - 1)) { 
                            $selected++ 
                        }
                    }
                    'Backspace' {
                        if ($query.Length -gt 0) {
                            $query = $query.Substring(0, $query.Length - 1)
                            $filteredItems = Get-FilteredItems -Items $Items -Query $query
                            $selected = 0
                        }
                    }
                    default {
                        if ($key.KeyChar -match '[a-zA-Z0-9\s\.\-_/\\]') {
                            $query += $key.KeyChar
                            $filteredItems = Get-FilteredItems -Items $Items -Query $query
                            $selected = 0
                        }
                    }
                }
            }
        }
        finally {
            [Console]::CursorVisible = $true
            Clear-Host
        }
    }

    function Get-FilteredItems {
        param(
            [array]$Items,
            [string]$Query
        )
        
        if ([string]::IsNullOrWhiteSpace($Query)) {
            return $Items
        }
        
        # Convert query to regex pattern for fuzzy matching
        $queryChars = $Query.ToCharArray()
        $escapedChars = $queryChars | ForEach-Object { [regex]::Escape($_) }
        $fuzzyPattern = $escapedChars -join '.*'
        
        $filtered = $Items | Where-Object { $_ -match $fuzzyPattern } | Sort-Object {
            # Score by how early the match starts and how compact it is
            $match = [regex]::Match($_, $fuzzyPattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
            if ($match.Success) {
                return $match.Index * 1000 + $match.Length
            }
            return 999999
        }
        
        return $filtered
    }

    function Get-Files {
        param([string]$RegexPattern = "")
        
        try {
            # Get all files recursively, excluding common directories to ignore
            $excludeDirs = @('.git', 'node_modules', '.vs', 'bin', 'obj', '.vscode', '__pycache__', '.idea', 'target', 'dist', 'build')
            
            $files = Get-ChildItem -Recurse -File -Force -ErrorAction SilentlyContinue | Where-Object {
                $file = $_
                # Check if file is not in excluded directories
                $inExcludedDir = $false
                foreach ($excludeDir in $excludeDirs) {
                    if ($file.FullName -like "*\$excludeDir\*") {
                        $inExcludedDir = $true
                        break
                    }
                }
                
                if ($inExcludedDir) { 
                    return $false 
                }
                
                # Apply regex filter if provided
                if (![string]::IsNullOrWhiteSpace($RegexPattern)) {
                    return $file.Name -match $RegexPattern
                }
                
                return $true
            }
            
            # Convert to relative paths for cleaner display
            $currentPath = (Get-Location).Path
            $result = $files | ForEach-Object { 
                $relativePath = $_.FullName.Replace($currentPath + '\', '')
                $relativePath.Replace('\', '/')
            } | Sort-Object
            
            return $result
        }
        catch {
            Write-Error "Error getting files: $_"
            return @()
        }
    }

    # Main execution
    Write-Host "Searching for files..." -ForegroundColor Yellow

    # Get files with optional regex filtering
    $files = Get-Files -RegexPattern $Pattern

    if ($files.Count -eq 0) {
        if (![string]::IsNullOrWhiteSpace($Pattern)) {
            Write-Host "No files found matching pattern: $Pattern" -ForegroundColor Red
        } else {
            Write-Host "No files found in current directory." -ForegroundColor Red
        }
        return
    }

    # Show interactive menu
    $selectedFile = Show-Menu -Items $files -Prompt "Select file to open in neovim"

    if ($selectedFile) {
        Write-Host "Opening: $selectedFile" -ForegroundColor Green
        
        # Check if neovim is available
        if (Get-Command nvim -ErrorAction SilentlyContinue) {
            & nvim $selectedFile
        } elseif (Get-Command vim -ErrorAction SilentlyContinue) {
            Write-Host "neovim not found, using vim instead" -ForegroundColor Yellow
            & vim $selectedFile
        } else {
            Write-Host "Neither neovim nor vim found. Please install neovim." -ForegroundColor Red
            Write-Host "Selected file: $selectedFile" -ForegroundColor Cyan
        }
    } else {
        Write-Host "Cancelled." -ForegroundColor Yellow
    }
}


function fx
{
	$file = fzf
	if ($file) { hx $file }
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })

function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}

function journald { Set-Location "~\Projects\Journal" }

function padmin
{
	if ($args.Count -gt 0)
	{
		$argList = $args -join ' '
		Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
	} else
	{
		Start-Process wt -Verb runAs
	}
}

# if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
	Import-Module Terminal-Icons
# }

Set-Alias grep rg
Set-Alias rep findstr
Set-Alias gcal gcalcli
Set-Alias ai aichat
Set-Alias tj tjournal
Set-Alias dj dijo
Set-Alias doo dooit
Set-Alias lg lazygit

function erase { Remove-Item -LiteralPath $args[0] -Recurse -Force }

# $SETTINGS = "C:\Users\HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$SETTINGS = Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'

function touch($file) { "" | Out-File $file -Encoding ASCII }

function uptime
{
	try
	{
		if ($PSVersionTable.PSVersion.Major -eq 5)
		{
			$lastBoot = (Get-WmiObject win32_operatingsystem).LastBootUpTime
			$bootTime = [System.Management.ManagementDateTimeConverter]::ToDateTime($lastBoot)
		} else
		{
			$lastBootStr = net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
			if ($lastBootStr -match '^\d{2}/\d{2}/\d{4}')
			{
				$dateFormat = 'dd/MM/yyyy'
			} elseif ($lastBootStr -match '^\d{2}-\d{2}-\d{4}')
			{
				$dateFormat = 'dd-MM-yyyy'
			} elseif ($lastBootStr -match '^\d{4}/\d{2}/\d{2}')
			{
				$dateFormat = 'yyyy/MM/dd'
			} elseif ($lastBootStr -match '^\d{4}-\d{2}-\d{2}')
			{
				$dateFormat = 'yyyy-MM-dd'
			} elseif ($lastBootStr -match '^\d{2}\.\d{2}\.\d{4}')
			{
				$dateFormat = 'dd.MM.yyyy'
			}
            
			if ($lastBootStr -match '\bAM\b' -or $lastBootStr -match '\bPM\b')
			{
				$timeFormat = 'h:mm:ss tt'
			} else
			{
				$timeFormat = 'HH:mm:ss'
			}

			$bootTime = [System.DateTime]::ParseExact($lastBootStr, "$dateFormat $timeFormat", [System.Globalization.CultureInfo]::InvariantCulture)
		}

		$formattedBootTime = $bootTime.ToString("dddd, MMMM dd, yyyy HH:mm:ss", [System.Globalization.CultureInfo]::InvariantCulture) + " [$lastBootStr]"
		Write-Host "System started on: $formattedBootTime" -ForegroundColor DarkGray

		$uptime = (Get-Date) - $bootTime

		$days = $uptime.Days
		$hours = $uptime.Hours
		$minutes = $uptime.Minutes
		$seconds = $uptime.Seconds

		Write-Host ("Uptime: {0} days, {1} hours, {2} minutes, {3} seconds" -f $days, $hours, $minutes, $seconds) -ForegroundColor Blue
        
	} catch { Write-Error "An error occurred while retrieving system uptime." }
}

Set-Alias unzip Expand-Archive

function which($name) { Get-Command $name | Select-Object -ExpandProperty Definition }

function pkill($name) { Get-Process $name -ErrorAction SilentlyContinue | Stop-Process }

function pgrep($name) { Get-Process $name }

function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }

function mkcd { param($dir) mkdir $dir -Force; Set-Location $dir }

function trash($path)
{
	$fullPath = (Resolve-Path -Path $path).Path

	if (Test-Path $fullPath)
	{
		$item = Get-Item $fullPath

		if ($item.PSIsContainer)
		{
			$parentPath = $item.Parent.FullName
		} else { $parentPath = $item.DirectoryName }

		$shell = New-Object -ComObject 'Shell.Application'
		$shellItem = $shell.NameSpace($parentPath).ParseName($item.Name)

		if ($item)
		{
			$shellItem.InvokeVerb('delete')
			Write-Host "Item '$fullPath' has been moved to the Recycle Bin."
		} else { Write-Host "Error: Could not find the item '$fullPath' to trash." }
	} else { Write-Host "Error: Item '$fullPath' does not exist." }
}

function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }

function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

# Does the the rough equivalent of dir /s /b. For example, dirs *.png is dir /s /b *.png
function dirs
{
	if ($args.Count -gt 0)
	{
		Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
	} else
	{
		Get-ChildItem -Recurse | Foreach-Object FullName
	}
}

function cpy { Set-Clipboard $args[0] }

function pst { Get-Clipboard }

$Env:YAZI_FILE_ONE = 'C:\Program Files\Git\usr\bin\file.exe'

# ==============================
# Fzf functions for PowerShell
# ==============================

# Find files using fzf
function f {
    $selection = fd --type f --hidden --exclude .git --max-depth 5 | 
        fzf --preview 'bat --style=numbers --color=always {}'
    if ($selection) { nvim $selection }
}

# Find a directory using fzf
function ff {
    $selection = fd --type d --hidden --exclude .git --max-depth 5 | 
        fzf --preview 'Get-ChildItem {} | Format-Table -AutoSize | Out-String'
    
    if ($selection) {
        Set-Location $selection
    }
}

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

Invoke-Expression (&starship init powershell)


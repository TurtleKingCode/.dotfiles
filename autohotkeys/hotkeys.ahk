#Requires AutoHotkey v2.0+
; FirstHotkey

!p::
{
	; Attempt to find a window with the executable name 'WindowsTerminal.exe'
	if WinExist("ahk_exe WindowsTerminal.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Windows Terminal
		Run "wt.exe"
	}
}

!w::
{
	; Attempt to find a window with the executable name 'wezterm-gui.exe'
	if WinExist("ahk_exe wezterm-gui.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Windows Terminal
		Run "C:\Program Files\WezTerm\wezterm-gui.exe"
	}
}


![::
{
	; Attempt to find a window with the executable name 'zen.exe'
	if WinExist("ahk_exe zen.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Zen
		Run "C:\Program Files\Zen Browser\zen.exe"
		; Run "C:\Users\turtl\Projects\Extensions\ZenExtensionAi\extension-launcher.bat"
	}
}

!c::
{
	; Attempt to find a window with the executable name 'msedge.exe'
	if WinExist("ahk_exe msedge.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Microsoft Edge
		Run "msedge.exe"
	}
}

; !;::
; {
; 	; Attempt to find a window with the executable name 'Todoist.exe'
; 	if WinExist("ahk_exe Todoist.exe")
; 	{
; 		; If found, activate and bring it to the foreground
; 		WinActivate
; 		WinShow
; 	}
; 	else
; 	{
; 		; If not found, run a new instance of Todoist
; 		Run "C:\Users\turtl\AppData\Local\Programs\todoist\Todoist.exe"
; 	}
; }

!'::
{
	; Attempt to find a window with the executable name 'ToggleTrack.exe'
	if WinExist("ahk_exe ToggleTrack.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of TogglTrack
		Run "C:\Users\turtl\AppData\Local\TogglTrack\TogglTrack.exe"
	}
}

!/::
{
	; Attempt to find a window with the executable name 'Notion Calendar.exe'
	if WinExist("ahk_exe Notion Calendar.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Notion Calendar
		Run "C:\Users\turtl\AppData\Local\Programs\notion-calendar-web\Notion Calendar.exe"
	}
}


!n::
{
	; Attempt to find a window with the executable name 'Notepad.exe'
	if WinExist("ahk_exe notepad.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Notepad
		Run "notepad"
	}
}

!o::
{
	; Attempt to find a window with the executable name 'Obsidian.exe'
	if WinExist("ahk_exe Obsidian.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Obsidian
		Run "C:\Users\turtl\AppData\Local\Programs\Obsidian\Obsidian.exe"
	}
}

; ~Alt & t::  ; The tilde (~) allows the key to fall through to the system
; {
;     if !WinExist("ahk_exe TickTick.exe")
;     {
;         Run "C:\Program Files (x86)\TickTick\TickTick.exe"
;         return  ; Prevents further action after launching
;     }
;     ; Else, do nothing: key falls through due to ~ modifier
; }
; ~!t::
; {
; 	; Attempt to find a window with the executable name 'TickTick.exe'
; 	if !WinExist("ahk_exe TickTick.exe")
; 	{
; 		; If not found, run a new instance of TickTick
; 			Run "C:\Program Files (x86)\TickTick\TickTick.exe"
; 			return
; 	} else {
; 		; otherwise, release Alt + T
;
; 		}
; }

!v::
{
	; Attempt to find a window with the executable name 'Code.exe'
	if WinExist("ahk_exe Code.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of VS Code
		Run "C:\Users\turtl\AppData\Local\Programs\Microsoft VS Code\Code.exe"
	}
}

; !c::
; {
; 	; Attempt to find a window with the executable name 'Chrome.exe'
; 	if WinExist("ahk_exe Chrome.exe")
; 	{
; 		; If found, activate and bring it to the foreground
; 		WinActivate
; 		WinShow
; 	}
; 	else
; 	{
; 		; If not found, run a new instance of Google Chrome
; 		Run "C:\Program Files\Google\Chrome\Application\Chrome.exe"
; 	}
; }

; !]::
; {
; 	; Attempt to find a window with the executable name 'chrome.exe'
; 	if WinExist("ahk_exe chrome.exe")
; 	{
; 		; If found, activate and bring it to the foreground
; 		WinActivate
; 		WinShow
; 	}
; 	else
; 	{
; 		; If not found, run a new instance of Helium Browser
; 		Run "C:\Users\turtl\AppData\Local\imput\Helium\Application\chrome.exe"
; 	}
; }

!]::
{
	; Attempt to find a window with the executable name 'chrome.exe'
	if WinExist("ahk_exe chrome.exe")
	{
		if !WinActivate("ahk_exe chrome.exe")
		{
			; If found, activate and bring it to the foreground
				WinActivate
				WinShow
		} 
		else {
			Send("!{`}")
			return
		}
	}
	else
	{
		; If not found, run a new instance of Helium Browser
		Run "C:\Users\turtl\AppData\Local\imput\Helium\Application\chrome.exe"
	}
}

; !]::
; {
; 	; Attempt to find a window with the executable name 'Comet.exe'
; 	if WinExist("ahk_exe Comet.exe")
; 	{
; 		; If found, activate and bring it to the foreground
; 		WinActivate
; 		WinShow
; 	}
; 	else
; 	{
; 		; If not found, run a new instance of Perplexity Comet
; 		Run "C:\Users/turtl/AppData/Local/Perplexity/Comet/Application/comet.exe"
; 	}
; }

!+/::
{
	; Attempt to find a window with the executable name 'Notion.exe'
	if WinExist("ahk_exe Notion.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Notion
		Run "C:\Users\turtl\AppData\Local\Programs\Notion\Notion.exe"
	}
}

!r::
{
	; Attempt to find a window with the executable name 'WinWord.exe'
	if WinExist("ahk_exe WinWord.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of WinWord
		Run "WinWord.exe"
	}
}

; Press Alt + E to minimize the active window immediately
!e::WinMinimize('A')

; Press Alt + F to toggle the active window between maximized and normal
; !f:: {
;     hwnd := WinExist("A")
;     if WinGetMinMax(hwnd) = 1  ; 1 = maximized, 0 = normal, -1 = minimized
;         WinRestore(hwnd)
;     else
;         WinMaximize(hwnd)
; }

; Press Alt + Enter to toggle the active window between maximized and normal (if it's not WindowsTerminal)
!Enter::
{
    hwnd := WinExist("A")
    exe := WinGetProcessName(hwnd)

    if (exe = "WindowsTerminal.exe") {
        ; Pass Alt+Enter through to Windows Terminal
        Send("!{Enter}")
        return
    }

    ; For other windows: maximize/restore
    if WinGetMinMax(hwnd) = 1
        WinRestore(hwnd)
    else
        WinMaximize(hwnd)
}

; Remap CapsLock to Escape
CapsLock::Esc

; Remap Alt+CapsLock to CapsLock
!CapsLock::CapsLock

; Turn off CapsLock when Shift is pressing alone
~LShift::
{
    if GetKeyState("CapsLock", "T")
    {
        KeyWait "LShift"
        if (A_PriorKey = "LShift")
        {
            SetCapsLockState false
        }
    }
}

Home::Send "{Volume_Up}"
PgUp::Send "{Volume_Down}"
+Home::Send "{Media_Play_Pause}"
+PgUp::SoundSetVolume 0
PgDn::PgUp
End::PgDn
!m::Send "{Media_Play_Pause}"
!+m::SoundSetVolume 0

!F11::F11
Volume_Up::Home
Volume_Down::End

; Close program with Alt+X
!x::!F4
!f::F11

:*:]t::
{
	Send FormatTime(, "H:mm:ss")
}

; Load email hotstrings
if FileExist(A_ScriptDir "..\private\autohotkeys\emailhotstrings.ahk")
{
    #Include ..\private\autohotkeys\emailhotstrings.ahk
}

; Email Hotstring Format
; :*:@@p::
; {
; 	Send "personal.email@gmail.com"
; }

; #Hotstring EndChars ()[]{}:;'"/\,.?!`n `t

; Enabling en and em dashes on keyboard
:*:,,-::–
:*:..-::—

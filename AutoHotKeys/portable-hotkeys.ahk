#Requires AutoHotkey v2.0+
; PortableHotkey

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

!]::
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

![::
{
	; Attempt to find a window with the executable name 'Chrome.exe'
	if WinExist("ahk_exe Chrome.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Google Chrome
		Run "C:\Program Files\Google\Chrome\Application\chrome.exe"
	}
}

!c::
{
	; Attempt to find a window with the executable name 'Chrome.exe'
	if WinExist("ahk_exe Chrome.exe")
	{
		; If found, activate and bring it to the foreground
		WinActivate
		WinShow
	}
	else
	{
		; If not found, run a new instance of Google Chrome
		Run "C:\Program Files\Google\Chrome\Application\chrome.exe"
	}
}

; Press Alt + E to minimize the active window immediately
!e::WinMinimize('A')

; Press Alt + F to toggle the active window between maximized and normal
!f:: {
    hwnd := WinExist("A")
    if WinGetMinMax(hwnd) = 1  ; 1 = maximized, 0 = normal, -1 = minimized
        WinRestore(hwnd)
    else
        WinMaximize(hwnd)
}

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

!F11::F11
Volume_Up::Home
Volume_Down::End

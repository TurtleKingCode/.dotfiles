; RAlt & Space::Run "C:\Program Files\EverythingToolbar\EverythingToolbar.Launcher.exe"

; LAlt & p::Run "powershell", "C:\Users\turtl\"
; ; LAlt & u::Run "ubuntu"
; ; LAlt & e::
; ; if WinExist, "ahk_exe msedge.exe") {
; ;     if WinActive("ahk_exe msedge.exe")
; ;         WinMinimize ; If Edge is active, minimize it.
; ;     else
; ;         WinActivate ; If Edge is open but not active, bring it to the front.
; ; } else {
; ;     Run, msedge.exe ; If Edge is not open, launch it.
; ; }
; ; return
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; ^F4 focuses on excel and/or cycles through files
; 
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
; ^F4::
; 	IfWinNotExist, ahk_class XLMAIN ; If no excel program is open, open a new one
; 	{
; 		Run, EXCEL.EXE
; 	}
; 	GroupAdd, timExcel, ahk_class XLMAIN 		; Groups all windows of excel into 1 name
; 	if WinActive("ahk_exe EXCEL.EXE")
; 	{
; 		GroupActivate, timExcel, r				; Cycles through next instance of excel
; 	}
; 	else
; 	{
; 		WinActivate ahk_class XLMAIN 			; NOTE: you have to use WinActivatebottom? if you didn't create a window group.
; 		WinMaximize
; 	}
; Return
; if (PID := ProcessExist("notepad.exe"))
;     MsgBox "Notepad exists and has the Process ID " PID "."
; else
;     MsgBox "Notepad does not exist."




; wezterm-gui.exe Hotkey
; !w::
; {
; 	; Attempt to find a window with the executable name 'westerm-gui.exe'
; 	if WinExist("ahk_exe wezterm-gui.exe")
; 	{
; 		; If found, activate and bring it to the foreground
; 		WinActivate
; 		WinShow
; 	}
;	 else
; 	{
; 		; If not found, run a new instance of Windows Terminal
; 		Run "wezterm-gui.exe"
; 	}
; }

; Capslock Hotkey
; ; Remap Alt+CapsLock to CapsLock
; !CapsLock::CapsLock
; ; Remap Alt+CapsLock to Alt+Escape
; !CapsLock::!Escape
;}
; ; Toggle CapsLock with Alt + CapsLock (based on real state)
; !CapsLock::
; {
;     currentState := GetKeyState("CapsLock", "T")
;     SetCapsLockState(currentState ? "Off" : "On")
; }
; ; Remap CapsLock to Escape
; CapsLock::Send("{Escape}")

; ; Turn off CapsLock by pressing Left Shift key
; ~LShift::
; {
;     if GetKeyState("CapsLock", "T") {
;         SetCapsLockState("Off")
;     }
; }

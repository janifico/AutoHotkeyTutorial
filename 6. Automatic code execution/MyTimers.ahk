#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
SetTitleMatchMode, 2

SetTimer, ClosePopup
SetTimer, AntiScreenSaver
SetTimer, Close_Win_Full


ClosePopup:
IfWinActive, ahk_exe EXCEL.EXE
{
	WinWait, ahk_class #32770, Cannot open the Clipboard.
	WinClose, ahk_class #32770
}
return

AntiScreenSaver:
If ( A_TimeIdle > 59999 ) {
  MouseMove, 1 , 1,, R
  MouseMove, -1,-1,, R
}
return

Close_Win_Full:
IfWinExist, FULL
{
    WinActivate  ; Automatically uses the window found above (by IfWinExist).
    WinMaximize  ; same
    Send, {Down 3} {Enter}
}
return

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Pause::Run, calc.exe

^F3::Run, C:\Program Files\Everything\Everything.exe

#t::
if ( WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass") )
{
  Send !d
  Sleep 10    ; does nothing for 10 milliseconds ; can help with stability
  Send cmd{enter}
}
else
{
  Run, cmd, C:\Users\%A_UserName%
}
return


F8::WinMinimize, A

#SPACE::Winset, Alwaysontop, , A

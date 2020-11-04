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


Slowkeys(MainMenu, operation)
{
Send, !%MainMenu% ;<-- open the dropdown menu
Sleep, 175        ;<-- wait a bit
Send, %operation% ;<-- pick the command
}


#IfWinActive ahk_exe Everything.exe

; Wrapping clipboard in quotation marks
^v::
if regexmatch(clipboard, "\\") {
  Send, "%clipboard%"
} else { Send, ^v 
}
return

#IfWinActive ahk_exe chrome.exe

Pgdn::^Pgdn
Pgup::^Pgup

; Duplicate page
^k::
Send ^l
Send !{Enter}
return

#IfWinActive ahk_exe OUTLOOK.EXE

; Open the Address Book
F3::^+b

#IfWinActive ahk_exe WINWORD.EXE

; Move through windows
MButton::
WinActivateBottom, ahk_class OpusApp
return

#IfWinActive ahk_exe stats.exe ; SPSS

;Switch between Data View and Variable View
MButton::^t

;Run syntax (in syntax editor)
^Enter::^r
^NumpadEnter::^r

; New dataset
#d::
Slowkeys("f","nd")
return

; New syntax
#r::
Slowkeys("f","ns")
return

; Merge
#g::
Slowkeys("d","gv")
return

; Weight cases
#w::
Slowkeys("d","w")
return

; Aggregate
#a::
Slowkeys("d","a")
return

; Select cases
#s::
Slowkeys("d","s")
return

; Split file
#f::
Slowkeys("d","f")
return

; Custom tables
#c::
Slowkeys("a","bc")
return

#IfWinActive ahk_exe EXCEL.EXE

; Find, paste, and search
F1::
Send ^f
WinWaitActive, Find and Replace, , 2
if ErrorLevel
{
    return
}
else
{
    Send ^v{Enter}
	return
}

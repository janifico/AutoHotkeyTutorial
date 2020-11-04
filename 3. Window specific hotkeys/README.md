# AutoHotkey knows which program is active

A fundamental functionality of AutoHotkey is to have certain hotkeys working only when a particular program is active. 
[`#IfWinActive`](https://www.autohotkey.com/docs/commands/_IfWinActive.htm) is called a directive and will determine if a program is active. 
Any hotkey declared below it will only apply to that particular program unless another `#IfWinActive` is specified.


## Getting `ahk_exe` and `ahk_class`

Just launch `WindowSpy.ahk` and click on the window of the program you are making the hotkey for. 
You can use either one of `ahk_exe` and `ahk_class` to make hotkeys for that program. 
I made a habit of using `ahk_exe` so that is what we will be using here. 

## A simple example

In the following, `Page Up` and `Page Down` are assigned to shifting through tabs in Google Chrome by sending `CTRL + Page Up` and `CTRL + Page Down`, respectively.
`CTRL + K` duplicates the current tab by selecting the text in the address bar with `CTRL + L` and then creating a new tab with `Alt + Enter`.
In Outlook, I could never remember that `CTRL + Shift + B` was the shortcut to open the address book so I mapped `F3` to it.

```ahk
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
```

Hotkeys from different programs will not interfere with each other so you can use the same hotkey for different actions in different programs.

## Cycle through windows

[`WinActivate`](https://www.autohotkey.com/docs/commands/WinActivate.htm) lets you activate an existing window by matching its name or its class (use Window Spy to help you out).
[`WinActivateBottom`](https://www.autohotkey.com/docs/commands/WinActivateBottom.htm) does the same thing but is used to activate the least recently used window. 
In the following I use the middle mouse button to cycle through open Word documents. 
Notice the use of `ahk_class` as opposed to `ahk_exe` in the syntax.

```ahk
#IfWinActive ahk_exe WINWORD.EXE

; Move through windows
MButton::
WinActivateBottom, ahk_class OpusApp
return
```

## A more involving example

I often found myself copying some text and then searching for it.
The script below automates the searching part.
In this particular example I'm using it in Excel but it will probably work for other programs too.

```ahk
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
```

Let's dissect it slowly.
The hotkey we are using is `F1`. 
(This is usually the a shortcut for help but I never use it.)
We send the keystrokes `CTRL + F` to open the Find and Replace dialogue box. 
[`WinWaitActive`](https://www.autohotkey.com/docs/commands/WinWaitActive.htm) will wait for a window with _Find and Replace_ in the title. 
In this example, it will only wait for a maximum of `2` seconds, then it will error out. 
If an error is thrown, then nothing happens and the hotkey closes. 
Otherwise, the hotkey will press `CTRL + V` and `Enter`. 
This will paste whatever is in the clipboard and press `Enter` to search for it.

In the above notice that hotkey activation happens only in Excel but the hotkey's script will wait for an unrelated window to become available.
It is possible to make more complex scripts that move from one window to another, though we will not dive into it here.

## Updating `MyScript.ahk`

Here is the script we built previously with the new hotkeys added on.

```ahk
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
```

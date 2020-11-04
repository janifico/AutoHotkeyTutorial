# Automatic code execution

While hotkeys provide great functionality, you may wish to have a script execute automatically given certain conditions are met without user input.
It is also important to have the script continue to be active even after it has executed the first time. 
This is not an issue in scripts that contain hotkeys but I recommend you keep the code in this section in a script separated from your hotkeys.
Scripts that do not contain hotkeys execute only once. 
[#Persistent](https://www.autohotkey.com/docs/commands/_Persistent.htm) 
is necessary to keep the script running and repeating.

To create a repeatable piece of code you write out the code and put it in a labelled [subroutine](https://www.autohotkey.com/docs/Language.htm#subroutines). 
You may notice that this has functionality similar to a function.
A function is in fact a type of subroutine that can accept parameters and return a value.
You then call the label of the subroutine as an argument to [SetTimer](https://www.autohotkey.com/docs/commands/SetTimer.htm).

## Prevent automatic screen lock

Company provided computers typically have a Group Policy under which the screen timeout is controlled.
This can be a problem for when executing a task that takes a while to finish. 
Say, for example, you wish to install a system update while you take your break. 
To prevent the screen timeout from interfering you'd need to, for example, move the mouse every once in a while.
The script below will detect how long the system has been idle with [A_TimeIdle](https://www.autohotkey.com/docs/Variables.htm#User_Idle_Time) and execute if it has been idle for more than a minute.
The script will simply move the mouse by one pixel relative to its current position and back.


```ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent

SetTimer, AntiScreenSaver


AntiScreenSaver:
If ( A_TimeIdle > 59999 ) {
  MouseMove, 1 , 1,, R
  MouseMove, -1,-1,, R
}
return
```

## Automatically close a window whenever it shows up 

Message boxes about errors are informative but you have to close the message box yourself every time it shows up.
The script below will continually look for a message box with _Cannot open the Clipboard_ in it's title.
As you can see, it is for an error in Excel

```ahk
#Persistent

SetTimer, ClosePopup


ClosePopup:
IfWinActive, ahk_exe EXCEL.EXE
{
	WinWait, ahk_class #32770, Cannot open the Clipboard.
	WinClose, ahk_class #32770
}
return
```

In a particular situation I wanted to run a program that took several minutes to execute.
My first problem was the screen lock for which we have already seen a solution. 
My second problem was that the program would show a message indicating that the log was full and requested user input.
This message's window title contained the text _FULL_ and would sometimes open minimized.
[IfWinExist](https://www.autohotkey.com/docs/commands/WinExist.htm) 
detects whether the window is currently an open window even if it is not the active window.
[WinActivate](https://www.autohotkey.com/docs/commands/WinActivate.htm)
and [WinMaximize](https://www.autohotkey.com/docs/commands/WinMaximize.htm)
activate and maximize the detected window, respectively.
This combination is pretty much guaranteed to put the window in focus.

[SetTitleMatchMode](https://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm) 
controls how  text is matched in _WinTitle_.
Below it is defined to match the text anywhere in the window's title. 

```ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
SetTitleMatchMode, 2

SetTimer, AntiScreenSaver
SetTimer, Close_Win_Full


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
```


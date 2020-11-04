# Launching programs

## The `Run` command

To launch a program you use [`Run`](https://www.autohotkey.com/docs/commands/Run.htm) followed by the name of the executable you wish to run. 
Here's a few examples (notice that comments start with a semicolon).

```ahk
; Launches the calculator
Pause::Run, calc.exe

; https://www.voidtools.com/
^F3::Run, C:\Program Files\Everything\Everything.exe
```
Above, the `Pause` button is remapped to launch the calculator. 
`CTRL + F3` launches [Everything](https://www.voidtools.com/), my favourite file searching tool.
I picked `CTRL + F3` for the latter because `F3` is a shortcut for search in many programs so it's easy for me to remember.
I suggest you use a similar logic when you create your own hotkeys.
Since the calculator is a system application AutoHotkey knows where to find it and I don't need to specify the full path.
If you have a program that is not installed (such as a portable one), you can specify the full path just like in the `Everything.exe` example.

`Run` will also open websites with your default browser.
The following script will open the Google search engine.
I choose the hotkey `Win + I` because it is the default shortcut for opening the web browser on some Linux distributions.

```ahk
#i::Run, https://www.google.com
```

### Opening the command line in context sensitive fashion

In Linux, a commonly used shortcut for opening the terminal is `Win + T`.
To open the Windows command line similarly you could do 

```ahk
#t::Run, cmd
```

to get

```bat
Microsoft Windows [Version 10.0.19041.572]
(c) 2020 Microsoft Corporation. All rights reserved.

C:\AHK>
```

While this is perfectly fine, you will notice that it is not quite the same as when opening the command line from the _Start_ menu (shown below).

```bat
Microsoft Windows [Version 10.0.19041.572]
(c) 2020 Microsoft Corporation. All rights reserved.

C:\Users\ADMIN>
```

If you open the command line with the script your location will be `C:\AHK>` as opposed to `C:\Users\ADMIN>`.
There is an easy fix.
AutoHotkey has some [built-in variables](https://www.autohotkey.com/docs/Variables.htm), one of which is `A_UserName` - the current user's username.
To evaluate the variable as text we use the percent sign %.

```ahk
#t::Run, cmd, C:\Users\%A_UserName%
```

This nets the same result as opening the command line from the _Start_ menu.

We can go one step further and have the command line open with the location of the active explorer folder (if one is active).
If we use Window Spy on an explorer window we notice that the `ahk_class` is `CabinetWClass`.
We split the script of the `Win + T` hotkey in two; one for when a folder is in focus, and the other for the general case.
To do this we use an [if-else block](https://www.autohotkey.com/docs/commands/IfExpression.htm).
A combination of `if` and [`WinActive`](https://www.autohotkey.com/docs/commands/WinActive.htm) 
checks if an explorer window is in focus.
If it is, we use `Alt + D` to select the text in the address bar.
Then, we type in `cmd` and press `Enter`.
This launches the command line in the active folder location.
When the windows explorer is not in focus, the `else` part of the code executes.

```ahk
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
```

## Manipulating windows

AutoHotkey is capable of understanding various aspects of the window you have open such as we've seen with Window Spy. 
Here are two commands that manipulate the active window. 

```ahk
F8::WinMinimize, A

#SPACE::WinSet, Alwaysontop, , A
```

The `A` at the end of the [`WinMinimize`](https://www.autohotkey.com/docs/commands/WinMinimize.htm) and 
[`WinSet`](https://www.autohotkey.com/docs/commands/WinSet.htm) commands refers to the active window. 
The top command uses the function key `F8` as a hotkey (with no modifiers) and minimises the active window. 
(I found this surprisingly convenient, by the way!)
The bottom command uses `Win + Space` as the hotkey and is a toggle for making the active window always on top (of other windows).

## Updating `MyScript.ahk`

Your script (`C:\AHK\MyScript.ahk`) with the default template's code on top can look like this.

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
```

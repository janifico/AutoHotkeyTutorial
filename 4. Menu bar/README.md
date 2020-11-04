# Menu bar

In most programs, you can access the menu bar (or ribbon) by pressing `Alt`. 
This lets you navigate menu items with your keyboard. 
While it is certainly possible to use AutoHotkey to control the [mouse](https://www.autohotkey.com/docs/commands/Click.htm), using the keyboard is easier and, often, more reliable.
In most programs, `Alt + F` opens the _File_ dropdown and `N` opens a new blank file.

```ahk
Send, !f
Send, n
```

Here are two examples, once again in Excel used to clear the contents of a cell.

```ahk
#IfWinActive ahk_exe EXCEL.EXE

; Access clear content menu (in ribbon)
#w:: Send, !he

; Clear all content
#e:: Send, !hea
```

`Alt + H` activates the _Home_ ribbon and successive keystrokes access commands and sub-commands (where applicable).

```ahk
#IfWinActive ahk_exe EXCEL.EXE

; Access clear content menu (in ribbon)
#w:: Send, !he

; Clear all content
#e:: Send, !hea 

; Paste values only and transpose
#+s:: Send, {AppsKey}ssve{Enter}

; Turn on Autofilter
#f:: Send, ^+l  ; Ctrl + Alt + L built in shortcut
```
## Functions for reusability

When working with [SPSS](https://en.wikipedia.org/wiki/SPSS) I had issues with getting the second part of the keystrokes to register.
This might have been because my laptop was very slow. 
Regardless, this was an issue that I had to fix. 

My solution was to have the hotkey wait for a bit between opening the dropdown menu and selecting the command I wanted. 
While not the most elegant solution, it was fine.

```ahk
; New dataset
#d::
Send, !f
Sleep, 175
Send, nd
return
```

Not wanting to write the sleep command every time I tweaked the waiting period, I wrote a **function** and called it `Slowkeys`. 
`Slowkeys` takes two inputs, `MainMenu` and `operation`.
`MainMenu` is the letter of the menu I want to drop down, so `f` for _File_, `e` for _Edit_, etc. 
`operation` is the rest of the keystroke sequence to get to the function I want.
I declare the function at the top of the script, before any other hotkey - this makes for good code organisation.
The first line of `Slowkeys` presses `Alt` and the `MainMenu` letter.
Then there is a 175 millisecond wait.
The last line presses the remaining keys.

```ahk
Slowkeys(MainMenu, operation)
{
Send, !%MainMenu% ;<-- open the dropdown menu
Sleep, 175        ;<-- wait a bit
Send, %operation% ;<-- pick the command
}


; For functions in SPSS 
#IfWinActive ahk_exe stats.exe

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
```

Note that since `Slowkeys` is not a one-liner, you cannot use one-line syntax when using it such as
```ahk
#c:: Slowkeys("a","bc")
```

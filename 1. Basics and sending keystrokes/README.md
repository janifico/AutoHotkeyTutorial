# The basics

If you have already gone through the tutorial in the official documentation then you can skip this section.

## Hotkey syntax

A hotkey, in general, looks like this

```ahk
Esc::
MsgBox, Escape!!!!
return
```

The key you press here is the `Escape` key. 
In AutoHotkey syntax it's `Esc`. 
The two colons indicate the start of the actions that AutoHotkey will do. 
`return` ends the script.

For one line scripts you can use the following syntax, avoiding the `return` command. 

```ahk
Esc::MsgBox, Escape!
```

## Modifier keys

Special keys called modifier keys have symbols. 
These are as follows. 

Key | Symbol
-----|-------
CTRL | ^
Shift | +
Alt | !
Win | #

You would use a combination of these keys with another key on your keyboard. 
For example 

```ahk
^j::
MsgBox, You pressed CTRL + J
return

#!j::MsgBox, You pressed Win + Alt + J
```
A full list of keys is available in the [official AutoHotey documentation](https://www.autohotkey.com/docs/KeyList.htm).


## Sending Keystrokes

This is AutoHotkey's main feature. 
The [`Send`](https://www.autohotkey.com/docs/commands/Send.htm) command sends keystrokes so you could do

```ahk
^r::
Send, Sincerely,{enter}John Smith
return
```

Many full size desktop keyboards have a _Menu Key_ called the `AppsKey` in AutoHotkey.
This key opens the menu you would get by right clicking an object. 
Some laptops don't have this key so you can remap a less often used key to the `AppsKey` like so

```ahk
Pause::AppsKey
```

When I worked with AutoCAD I had peripherals with buttons from `F13` to `F24`. 
Windows recognises these so I had some commands mapped to them. 

```ahk
; Snap to nearest
F13::
Send, nea{Enter}
return

; Snap off
F14::
Send, non{Enter}
return

;Snap to end point
F15::
Send, endp{Enter}
return

; Edit polygon
F17::
Send, pedit{Enter}
return

; Mid between two points
F18::
Send, m2p{Enter}
return
```

I would sometimes get errors or unexpected behaviour if the context was different from what was expected but for the most part these where really useful.
Since the above are one line scripts then they can be rewritten as

```ahk
; Snap to nearest
F13::Send, nea{Enter}

; Snap off
F14::Send, non{Enter}

;Snap to end point
F15::Send, endp{Enter}

; Edit polygon
F17::Send, pedit{Enter}

; Mid between two points
F18::Send, m2p{Enter}
```

We will see how we can make such scripts apply to only the program they are intended for in a later section.

## Remark

AutoHotkey also supports [Hotstrings](https://www.autohotkey.com/docs/Hotstrings.htm).
Hotstrings are also a fundamental part of AutoHotkey functionality but will not be covered here.

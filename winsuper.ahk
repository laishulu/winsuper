#SingleInstance 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; call the script like 'MyAHK.exe "ik", then `Win-i` are remapped to `Ctrl-x @s, i`, so do `k`

delay := A_Args.Length() ? A_Args[1] : 100

Lwin::
  IfWinActive,ahk_class Emacs
  {  
    Send ^x
    Sleep %delay%
    Send % "@s"
    KeyWait, Lwin  
  } 
  else
  {
  Send {Lwin down}
  KeyWait, Lwin 
  send {Lwin up}
  }
Return


Rwin::
  IfWinActive,ahk_class Emacs
  {  
    Send ^x
    Sleep %delay%
    Send % "@s"
    KeyWait, Rwin  
  } 
  else
  {
  Send {Rwin down}
  KeyWait, Rwin 
  send {Rwin up}
  }
Return

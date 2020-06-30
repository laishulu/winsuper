#SingleInstance 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; call the script like 'MyAHK.exe "ik", then `Win-i` are remapped to `Ctrl-x @s, i`, so do `k`

keymap := {}
delay := A_Args.Length() ? A_Args[1] : 150
current := 0

; Hotkey, IfWinActive, ahk_class Emacs

if A_Args.Length() >= 2{
    For i, char in StrSplit(A_Args[2]){
        hk1 := "#" . char
        hk2 := "#+" . char
        keymap[hk1] := char
        keymap[hk2] := char
        Hotkey, %hk1%, Remap
        Hotkey, %hk2%, Remap
    }
} else {
    For i in range(ord("!"), ord("~")){
        char := chr(i)
        hk1 := "#" . char
        hk2 := "#+" . char
        keymap[hk1] := char
        keymap[hk2] := char
        Hotkey, %hk1%, Remap
        Hotkey, %hk2%, Remap
    }
}
Exit

GetChar() {
    local char := keymap[A_ThisHotkey]
    if InStr(A_ThisHotkey, "+") {
        StringUpper, char, char
    }
    return char
}

Remap:
Send ^x
Sleep % delay
Send % "@s" GetChar()
return

range(start, stop:="", step:=1) {
	static range := { _NewEnum: Func("_RangeNewEnum") }
	if !step
		throw "range(): Parameter 'step' must not be 0 or blank"
	if (stop == "")
		stop := start, start := 0
	; Formula: r[i] := start + step*i ; r = range object, i = 0-based index
	; For a postive 'step', the constraints are i >= 0 and r[i] < stop
	; For a negative 'step', the constraints are i >= 0 and r[i] > stop
	; No result is returned if r[0] does not meet the value constraint
	if (step > 0 ? start < stop : start > stop) ;// start == start + step*0
		return { base: range, start: start, stop: stop, step: step }
}

_RangeNewEnum(r) {
	static enum := { "Next": Func("_RangeEnumNext") }
	return { base: enum, r: r, i: 0 }
}

_RangeEnumNext(enum, ByRef k, ByRef v:="") {
	stop := enum.r.stop, step := enum.r.step
	, k := enum.r.start + step*enum.i
	if (ret := step > 0 ? k < stop : k > stop)
		enum.i += 1
	return ret
}

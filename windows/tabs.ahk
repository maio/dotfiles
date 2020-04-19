; Explanation of Signs
; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; &  An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.
; * - fires replacement immediately, O - removes default trigger character (ahk will be triggered with space)


; Previous Tab
#i::
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send, ^+{Tab down}{Tab up}
    Return  ; i.e. do nothing, which causes Control-P to do nothing in Notepad.
Send #i
return

; Next Tab
#k::
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send, ^{Tab down}{Tab up}
    Return  ; i.e. do nothing, which causes Control-P to do nothing in Notepad.
Send #k
return

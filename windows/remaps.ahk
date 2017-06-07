#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

+Capslock::Capslock
Capslock::Ctrl

$;::
  KeyWait, `;, T0.1
  If !ErrorLevel {
    Send, `;
    KeyWait, `;
  } Else {
    Send, {LCtrl Down}
    KeyWait, `;
    Send, {LCtrl Up}
  }
Return

#NoEnv
#SingleInstance Force
SendMode Input

; Physical key that starts the macro. Plain key name, no modifiers.
global TriggerKey := "Space"
; Key bound to jump in CS2.
global JumpKey := "Space"

global MinDelay := 2
global MaxDelay := 13
global SkipChance := 8
global SkipMinDelay := 20
global SkipMaxDelay := 40

global jumping := false

Hotkey, IfWinActive, ahk_exe cs2.exe
Hotkey, *%TriggerKey%, StartJumping
Hotkey, *%TriggerKey% Up, StopJumping
return

StartJumping() {
    if (jumping)
        return ; key repeat
    jumping := true
    Send, {%JumpKey%}
    ScheduleJump()
}

StopJumping() {
    jumping := false
    SetTimer, Jump, Off
}

Jump() {
    if (!GetKeyState(TriggerKey, "P") || !WinActive("ahk_exe cs2.exe")) {
        StopJumping()
        return
    }
    Send, {%JumpKey%}
    ScheduleJump()
}

ScheduleJump() {
    Random, roll, 1, 100
    if (roll <= SkipChance)
        Random, delay, SkipMinDelay, SkipMaxDelay
    else
        Random, delay, MinDelay, MaxDelay
    SetTimer, Jump, %delay%
}

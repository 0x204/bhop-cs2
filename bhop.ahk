JumpKey := "Space"
MinDelay := 2
MaxDelay := 13
BaseDelay := 8
fpsOn := false
isJumping := false
currentDelay := BaseDelay

#MaxThreadsPerHotkey 2

Hotkey, %JumpKey%, JumpKey_Press, On
Hotkey, %JumpKey% Up, JumpKey_Release, On

WheelUp::
WheelDown::
    Return

JumpKey_Press:
    if (!fpsOn)
    {
        fpsOn := true
        isJumping := true
        Random, currentDelay, MinDelay, MaxDelay
    }
    SetTimer, AutoBhop_Timer, %currentDelay%
Return

JumpKey_Release:
    if (fpsOn)
    {
        fpsOn := false
        isJumping := false
    }
    SetTimer, AutoBhop_Timer, Off
Return

AutoBhop_Timer:
    if GetKeyState(JumpKey, "P")
    {
        Send, {Space}
        Random, currentDelay, MinDelay, MaxDelay
        Random, skipChance, 1, 100
        if (skipChance <= 8)
        {
            Random, skipDelay, 12, 18
            SetTimer, AutoBhop_Timer, %skipDelay%
            Return
        }
        SetTimer, AutoBhop_Timer, %currentDelay%
    }
Return

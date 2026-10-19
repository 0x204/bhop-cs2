#Requires AutoHotkey v2.0
#SingleInstance Force

; Клавиша, которую зажимаешь, и клавиша, на которую в CS2 забинжен +jump
TriggerKey := "Space"
JumpKey := "Space"
; Включает и выключает макрос, например перед тем как писать в чат
ToggleKey := "F8"
; Пауза между прыжками, мс (Windows округляет вверх до 10–15.6)
RepeatInterval := 10
GameWindow := "ahk_exe cs2.exe"

; Нажатия идут через SendEvent без задержек. SendInput не подходит: на время каждой
; отправки AHK снимает свой хук клавиатуры, и отпускание клавиши может потеряться.
SetKeyDelay(-1, -1)

HotIfWinActive(GameWindow)
Hotkey("*" TriggerKey, Bhop)
Hotkey(ToggleKey, ToggleBhop, "S")

Bhop(*) {
    loop {
        SendEvent("{Blind}{" JumpKey "}")
        Sleep(RepeatInterval)
    } until ShouldStop()
}

ShouldStop() => A_IsSuspended || !GetKeyState(TriggerKey, "P") || !WinActive(GameWindow)

ToggleBhop(*) {
    Suspend(-1)
    SoundBeep(A_IsSuspended ? 400 : 800, 60)
}

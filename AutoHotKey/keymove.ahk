; ____________ Setup ______________
#NoEnv  ; Don't read environment variables
#SingleInstance force ; Allow only one instance of this script to run

SetCapsLockState, AlwaysOff

IsOneNoteActive()
{
    WinGet, activeProcName, ProcessName, A
    if (activeProcName = "ONENOTE.EXE")
        return true
    else
        return false
}

; ____________ Keys ______________

!w::Send ^{Left}+^{Right} ; More general Alt+W
Media_Play_Pause:: ; disable media auto-play

; 3-finger Middle-click override
; https://superuser.com/a/1601645/529867
;<#F22::MButton  ; Left Win + F22
;<#<^F22::MButton  ; Left Win + Left Ctrl + F22

#if GetKeyState("CapsLock", "P")
    ; Move Keys
    *j::send, {blind}{Left}
    *l::Send, {blind}{Right}
    *k::
        if (IsOneNoteActive())
            SendPlay, {blind}{Down}
        else
            Send, {blind}{Down}
        return
    *i::
        if (IsOneNoteActive())
            SendPlay, {blind}{Up}
        else
            Send, {blind}{Up}
        return
    *w::Send, {blind}{PgUp}
    *d::Send, {blind}{End}
    *s::Send, {blind}{PgDn}
    *a::Send, {blind}{Home}

    ; Delete Keys
    *h::Send, {blind}{Backspace}
    *`;::Send, {blind}{Delete} ; back-tick (`) escapes the comment

    ; Other
    *f::Send, {blind}{Esc}
    *u::Send, {blind}{RCtrl down}{RAlt down}{Tab}{RAlt up}{RCtrl up} ; Ctrl+Alt+Tab - switch window
    *~`::Send, {blind}!{F4} ; Alt-F4 (tilde to escape back-tick)
    *]::WinSet, AlwaysOnTop, toggle, A ; Pin window to top
    *[::Send, {blind}^{[} ; Ctrl+[ (back in Notion)

    ; Windows
    *,::WinMinimize,A ; Minimize window
    *.::Send, {blind}#{t} ; Win-T - Go to taskbar]
    */::Send, {blind}{AppsKey} ; Right-click menu key.

    ; VS2019 shortcuts
    *m::Send, {blind}^{F12} ; Ctrl+F12 - goto implementation
    *t::
        if (IsOneNoteActive())
            Send, {blind}^{e} ; Ctrl-E - search in OneNote
        else
            Send, {blind}^{t} ; Ctrl-T - launch Go To File
        return
    *e::Return ; AVAILABLE COMBO
    *r::Send, {blind}^+{p} ; Ctrl-Shift-P - launch Go To Member
    *g::Send, {blind}^{g} ; Ctrl-G - Go to line
    *=::Send, {blind}!+{=} ; Alt-Shift-= - Expand selection
    *-::Send, {blind}!+{-} ; Alt-Shift-- - Shrink selection
    *n::Send, {blind}^+{l} ; Ctrl-Shift-L - Delete Line
    *p::Send, {blind}!+{p} ; Alt-Shift-p - Toggle Pin tab
    *y::Send, {blind}!{y} ; Alt+y - Go to recent

    ; Copy-Paste replace
    *v:: Send, {blind}^{``}
    *z:: Send, {blind}^!{f} ; Ctrl-Alt-F - launch everything search
    ^+v::SendRaw %clipboard%
	
    ; Web Browser
    *q::Send, {blind}^{w} ; close tab in Chrome and VS2017 (custom bind)
    *7::Send, {blind}!{Left} ; Alt-Left -- Back
    *8::Send, {blind}!{Right} ; Alt-Right -- Forward
    *9::Send, {blind}^{PgUp} ; Ctrl-PgUp -- Previous tab
    *0::Send, {blind}^{PgDn} ; Ctrl-PgDn -- Next tab

    ; Travel Keyboard
    *2::Send, {blind}{F2} ; F2 - rename

    ; Mouse mode
    *3::
        Run, win-vind /f easyclick
        Run "keymouse.ahk" ; With the full file path specified, of course
        ExitApp
        return
    *4::
        Run "keymouse.ahk" ; With the full file path specified, of course
        ExitApp
        return
#if
SetCapsLockState, AlwaysOff

!w::Send ^{Left}+^{Right} ; More general Alt+W
Media_Play_Pause:: ; disable media auto-play

#if GetKeyState("CapsLock", "P")
    ; Move Keys
    *j::send, {blind}{Left}
    *l::Send, {blind}{Right}
    *k::Send, {blind}{Down}
    *i::Send, {blind}{Up}
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
    *\::WinSet, AlwaysOnTop, toggle, A ; Pin window to top
    *~`::Send, {blind}!{F4} ; Alt-F4 (tilde to escape back-tick)
    *~]::Send, {blind}#{t} ; Win-T - Go to taskbar

    ; VS2019 shortcuts
    *m::Send, {blind}^{F12} ; Ctrl+F12 - goto implementation
    *t::Send, {blind}^{t} ; Ctrl-T - launch Go To File
    *e::Return ; AVAILABLE COMBO
    *r::Send, {blind}^+{p} ; Ctrl-Shift-P - launch Go To Member
    *g::Send, {blind}^{g} ; Ctrl-G - Go to line
    *=::Send, {blind}!+{=} ; Alt-Shift-= - Expand selection
    *-::Send, {blind}!+{-} ; Alt-Shift-- - Shrink selection
    *n::Send, {blind}^+{l} ; Ctrl-Shift-L - Delete Line
    *[::Send, {blind}!+{[} ; Alt-Shift-[ - Go to head of block
    *p::Send, {blind}!+{p} ; Alt-Shift-p - Toggle Pin tab
    *y::Send, {blind}!{y} ; Alt+y - Go to recent

    ; Copy-Paste replace
    *v:: Send, {blind}^{``}
    *z:: Send, {blind}^!{f} ; Ctrl-Alt-F - launch everything search
    ^+v::SendRaw %clipboard%
	
    ; Web Browser
    *q::Send, {blind}^{w} ; close tab in Chrome and VS2017 (custom bind)
    *7::Send, {blind}!{Left} ; Alt-Left -- Back
    *8::Send, {blind}^{PgUp} ; Ctrl-PgUp -- Previous tab
    *9::Send, {blind}^{PgDn} ; Ctrl-PgDn -- Next tab
    *0::Send, {blind}!{Right} ; Alt-Right -- Forward


    ; Mouse mode
    *3::
        Run, win-vind --func easy_click_hover
        Run "keymouse.ahk" ; With the full file path specified, of course
        ExitApp
        return
    *4::
        Run "keymouse.ahk" ; With the full file path specified, of course
        ExitApp
        return
#if
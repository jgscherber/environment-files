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
    *`;::Send, {blind}{Delete}

    ; Other
    *f::Send, {blind}{Esc}
    *o::Send, {blind}!{Left}
    *u::Send, {blind}{RCtrl down}{RAlt down}{Tab}{RAlt up}{RCtrl up} ; Ctrl+Alt+Tab - switch window
    *\::WinSet, AlwaysOnTop, toggle, A ; Pin window to top

    ; VS2019 shortcuts
    *m::Send, {blind}^{F12} ; Ctrl+F12 - goto implementation
    *t::Send, {blind}^{t} ; Ctrl-T - launch Go To File
    ;*e::Send, {blind} ; AVAILABLE COMBO
    *r::Send, {blind}^{p} ; Ctrl-P - launch Go To Member
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
    *8::Send, {blind}^{PgUp} ; Previous tab
    *9::Send, {blind}^{PgDn} ; Next tab

    ; Mouse mode
    *b::
        ; Run "keymouse.ahk" ; needs to be in same directory
        ExitApp
    return
#if
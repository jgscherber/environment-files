SetCapsLockState, AlwaysOff

!w::Send ^{Left}+^{Right} ; More general Alt+W

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
    *q::Send, {blind}^{w} ; close tab in Chrome and VS2017 (custom bind)
    *u::Send, {blind}{RCtrl down}{RAlt down}{Tab}{RAlt up}{RCtrl up} ; Ctrl+Alt+Tab - switch window
    *y::Send, {blind}!{y} ; Alt+y - switch tabs

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

    ; Copy-Paste replace
    *v:: Send, {blind}{LWin down}{v}{LWin up}
    *z:: Send, {blind}^!{f} ; Ctrl-Alt-F - launch everything search
	

    ; Mouse mode
    *b::
        Run "keymouse.ahk" ; needs to be in same directory
        ExitApp
    return
#if
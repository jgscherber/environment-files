SetCapsLockState, AlwaysOff

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
    *o::Send, {blind}{AppsKey}
    *q::Send, {blind}^{w} ; close tab in Chrome and VS2017 (custom bind)
    *u::Send, {blind}{RCtrl down}{RAlt down}{Tab}{RAlt up}{RCtrl up} ; Ctrl+Alt+Tab - switch window
    *y::Send, {blind}!{y} ; Alt+y - switch tabs

    ; VS2019 shortcuts
    *m::Send, {blind}^{F12} ; Ctrl+F12 - goto implementation
    *e::Send, {blind}!w ; Alt+W - select word
    *t::Send, {blind}^{t} ; Ctrl-T - launch Go To File
    *r::Send, {blind}^{p} ; Ctrl-P - launch Go To Member
    *g::Send, {blind}^{g} ; Ctrl-G - Go to line
    *=::Send, {blind}!+{=} ; Alt-Shift-= - Expand selection
    *-::Send, {blind}!+{-} ; Alt-Shift-- - Shrink selection
    *n::Send, {blind}^+{l} ; Ctrl-Shift-L - Delete Line

    ; Copy-Paste replace
    *v:: Send, {blind}^{v}
    *c:: Send, {blind}^{c}
    *x:: Send, {blind}^{x}
#if
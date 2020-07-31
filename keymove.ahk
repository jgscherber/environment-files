SetCapsLockState, AlwaysOff

CapsLock & j::Send, {blind}{Left}
CapsLock & k::Send, {blind}{Down}
CapsLock & l::Send, {blind}{Right}
CapsLock & i::Send, {blind}{Up}

CapsLock & w::Send, {blind}{PgUp}
CapsLock & d::Send, {blind}{End}
CapsLock & s::Send, {blind}{PgDn}
CapsLock & a::Send, {blind}{Home}

CapsLock & h::Send, {blind}{Backspace}
CapsLock & `;::Send, {blind}{Delete}

; Other
CapsLock & f::Send, {blind}{Esc}
CapsLock & o::Send, {blind}{AppsKey}

CapsLock & q::Send, {blind}^{w} ; close tab in Chrome and VS2017 (custom bind)
CapsLock & u::Send, {blind}^!{Tab} ; Ctrl+Alt+Tab - switch window
CapsLock & y::Send, {blind}!{y} ; Alt+y - switch tabs


; VS2019 shortcuts
CapsLock & m::Send, {blind}^{F12} ; Ctrl+F12 - goto implementation
CapsLock & e::Send, {blind}!w ; Alt+W - select word
CapsLock & t::Send, {blind}^{t} ; Ctrl-T - launch Go To File
CapsLock & r::Send, {blind}^{p} ; Ctrl-P - launch Go To Member
CapsLock & g::Send, {blind}^{g} ; Ctrl-G - Go to line
CapsLock & =::Send, {blind}!+{=} ; Alt-Shift-= - Expand selection
CapsLock & -::Send, {blind}!+{-} ; Alt-Shift-- - Shrink selection
CapsLock & n::Send, {blind}^+{l} ; Ctrl-Shift-L - Delete Line

; Copy-Paste replace
CapsLock & v:: Send, {blind}{LWin down}{v}{LWin up}
CapsLock & c:: Send, {blind}^{c}
CapsLock & x:: Send, {blind}^{x}


; CapsLock & u::Send, {blind}{Click, %A_CaretX%, %A_CaretY%, 2}
; CapsLock & o::Send, {blind}{Click, %A_CaretX%, %A_CaretY%, 3}
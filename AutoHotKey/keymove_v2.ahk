 ; SendMode "SendEvent"
SetCapsLockState "AlwaysOff"

Media_Play_Pause:: ; disable media auto-play
!w::Send "^{Left}+^{Right}" ; More general Alt+W

#Hotif GetKeyState("CapsLock", "P")
    ; Move Keys
    j::Send "{Blind}{Left}"
    l::Send "{Blind}{Right}"
    k::Send "{Blind}{Down}"
    i::Send "{Blind}{Up}"
    w::Send "{Blind}{PgUp}"
    d::Send "{Blind}{End}"
    s::Send "{Blind}{PgDn}"
    a::Send "{Blind}{Home}"

    ; Delete Keys
    h::Send "{Blind}{Backspace}"
    `;::Send "{Blind}{Delete}" ; back-tick (`) escapes the comment

    ; Other
    f::Send "{Blind}{Esc}"
    u::Send "{Blind}{RCtrl down}{RAlt down}{Tab}{RAlt up}{RCtrl up}" ; Ctrl+Alt+Tab - switch window
    \::WinSetAlwaysOnTop -1 ; Pin window to top
    `::Send "{Blind}!{F4}" ; Alt-F4 (tilde to escape back-tick)
    ]::Send "{Blind}#{t}" ; Win-T - Go to taskbar

    ; VS2019 shortcuts
    m::Send "{Blind}^{F12}" ; Ctrl+F12 - goto implementation
    t::Send "{Blind}^{t}" ; Ctrl-T - launch Go To File
    ;e::Send "{Blind}" ; AVAILABLE COMBO
    r::Send "{Blind}^{p}" ; Ctrl-P - launch Go To Member
    g::Send "{Blind}^{g}" ; Ctrl-G - Go to line
    =::Send "{Blind}!+{=}" ; Alt-Shift-= - Expand selection
    -::Send "{Blind}!+{-}" ; Alt-Shift-- - Shrink selection
    n::Send "{Blind}^+{l}" ; Ctrl-Shift-L - Delete Line
    [::Send "{Blind}!+{[}" ; Alt-Shift-[ - Go to head of block
    p::Send "{Blind}!+{p}" ; Alt-Shift-p - Toggle Pin tab
    y::Send "{Blind}!{y}" ; Alt+y - Go to recent


#Hotif


; Many thanks to Chris for helping me out with this script.
; https://www.autohotkey.com/board/topic/1257-half-qwerty-one-handed-typing/
;http://half-qwerty.com/resources/images/rightboard.gif

mirror_1 = 0
mirror_2 = 9
mirror_3 = 8
mirror_4 = 7
mirror_5 = 6
mirror_q = p
mirror_w = o
mirror_e = i
mirror_r = u
mirror_t = y
mirror_a = `;
mirror_s = l
mirror_d = k
mirror_f = j
mirror_g = h
; reverse for . and , handled below in if-statement (invalid var names)
mirror_z = .
mirror_x = ,
mirror_c = m
mirror_v = n
mirror_b = b
mirror_6 = 5
mirror_7 = 4
mirror_8 = 3
mirror_9 = 2
mirror_0 = 1
mirror_y = t
mirror_u = r
mirror_i = e
mirror_o = w
mirror_p = q
mirror_h = g
mirror_j = f
mirror_k = d
mirror_l = s
mirror_n = v
mirror_m = c
return


; This key may help, as the space-on-up may get annoying, especially if you type fast.
Control & Space::Suspend

; These keys are optional, but they may help if you are typing on the left-hand side.
; CapsLock::Send, {BackSpace}
; Space & CapsLock::Send, {Enter}

;TODO change to trigger on space-down >> but then can't hold and type multiple
; if space is pressed, send space (so double tap for space)
; if key, send mirror and space-up

; TODO better way to handle shift... //www.autohotkey.com/board/topic/41510-is-there-any-way-to-get-shift-to-toggle-like-caps-lock/?p=259395

; If spacebar didn't modify anything, send a real space keystroke upon release.
space::
Send {space}
return

space & 1::
space & 2::
space & 3::
space & 4::
space & 5::
space & q::
space & w::
space & e::
space & r::
space & t::
space & a::
space & s::
space & d::
space & f::
space & g::
space & z::
space & x::
space & c::
space & v::
space & b::
space & `;::
space & ,::
space & .::
space & /::
space & 6::
space & 7::
space & 8::
space & 9::
space & 0::
space & -::
space & y::
space & u::
space & i::
space & o::
space & p::
space & h::
space & j::
space & k::
space & l::
space & Enter::
space & n::
space & m::
space & [::

; Determine the mirror key, if there is one:
if A_ThisHotkey = space & `;
   MirrorKey = a
else if A_ThisHotkey = space & ,
   MirrorKey = x
else if A_ThisHotkey = space & .
   MirrorKey = z
else if A_ThisHotkey = space & /
   MirrorKey = z
else if A_ThisHotkey = space & -
  MirrorKey = ``
else if A_ThisHotkey = space & [
  MirrorKey = Tab
else  ; To avoid runtime errors due to invalid var names, do this part last.
{
   StringRight, ThisKey, A_ThisHotkey, 1
   StringTrimRight, MirrorKey, mirror_%ThisKey%, 0  ; Retrieve "array" element.
   if MirrorKey =  ; No mirror, script probably needs adjustment.
      return
}

Modifiers =
GetKeyState, state1, LWin
GetKeyState, state2, RWin
state = %state1%%state2%
if state <> UU  ; At least one Windows key is down.
   Modifiers = %Modifiers%#
GetKeyState, state1, Control
if state1 = D
   Modifiers = %Modifiers%^
GetKeyState, state1, Alt
if state1 = D
   Modifiers = %Modifiers%!
GetKeyState, state1, Shift
if state1 = D
   Modifiers = %Modifiers%+
Send %Modifiers%{%MirrorKey%}
return
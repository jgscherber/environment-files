SetDefaultMouseSpeed, 0 
SetCapsLockState, AlwaysOff

; SETTINGS
; --------
; futz with these to get the movement as you'd like it
; the settings below are the ones i liked after just
; a few minutes of playing around
distance := 10           ; - how far the mouse moves each turn of the timer
x_multiplier := 1.12     ; - how much farther (exponentially) the mouse moves in
y_multiplier := 1.09     ;   a direction the longer you hold that direction down
d := 1
u := 1
l := 1
r := 1
left_mouse_d := 1

SetTimer, CheckForKeyMouse, 30
return

; https://autohotkey.com/board/topic/37947-turn-keyboard-into-mouse/

j::vkE8
l::vkE8
i::vkE8
k::vkE8
b:: 
    Run "keymove.ahk" ; With the full file path specified, of course
    ExitApp
    return
s:: MouseClick, left ; when you press q, mouse will left click
f:: MouseClick, right ; when you press e, mouse will right click
e:: MouseClick, WheelUp
d:: MouseClick, WheelDown
w:: MouseClick, WheelLeft
r:: MouseClick, WheelRight
a:: MouseClick, Middle



CheckForKeyMouse()
{
    global y_multiplier
    global x_multiplier
    global distance
    global d
    global u
    global l
    global r

    ; can ignore their actual input by rebind to "vkE8" (dummy key)
    ; https://www.autohotkey.com/boards/viewtopic.php?t=78740
	GetKeyState("k", "P") ? (d*=y_multiplier) : (d:=1)
	GetKeyState("i", "P") ? (u*=y_multiplier) : (u:=1)
	GetKeyState("l", "P") ? (r*=x_multiplier) : (r:=1)
	GetKeyState("j", "P") ? (l*=x_multiplier) : (l:=1)	
	y := (d-u) * distance
	x := (r-l) * distance
	MouseMove, x, y, , R
}


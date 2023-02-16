SetDefaultMouseSpeed, 0 
SetCapsLockState, AlwaysOff

; SETTINGS
; --------
; futz with these to get the movement as you'd like it
; the settings below are the ones i liked after just
; a few minutes of playing around
distance := 10           ; - how far the mouse moves each turn of the timer
x_multiplier := 1.11     ; - how much farther (exponentially) the mouse moves in
y_multiplier := 1.09     ;   a direction the longer you hold that direction down
d := 1
u := 1
l := 1
r := 1
left_mouse_d := 1

SetTimer, CheckForKeyMouse, 10
return

; https://autohotkey.com/board/topic/37947-turn-keyboard-into-mouse/

#if GetKeyState("CapsLock", "P")
    *j::vkE8 ; "vkE8" (dummy key to ignore input)
    *l::vkE8 ; "vkE8" (dummy key to ignore input)
    *i::vkE8 ; "vkE8" (dummy key to ignore input)
    *k::vkE8 ; "vkE8" (dummy key to ignore input)
    *f::
      MouseClick, left
      ReturnToKeyMove()
    *g::
      MouseClick, right
      ReturnToKeyMove()
    *w::Send, { WheelUp }
    *s::Send, { WheelDown }
    *a::Send, { WheelLeft }
    *d::Send, { WheelRight }
    *r::
      MouseClick, Middle
      ReturnToKeyMove()

    *3::
      RunWait, win-vind --func easy_click_hover

    *q::ReturnToKeyMove()
    *u::ReturnToKeyMove()
#if

ReturnToKeyMove()
{
    Run "keymove.ahk" ; With the full file path specified, of course
    Sleep 500 ; give a half-second for script to start
    ExitApp
    return
}


CheckForKeyMouse()
{
    global y_multiplier
    global x_multiplier
    global distance
    global d
    global u
    global l
    global r

    ; Actual input is ignored by rebind to "vkE8" (dummy key)
    ; https://www.autohotkey.com/boards/viewtopic.php?t=78740
    #if GetKeyState("CapsLock", "P")
        GetKeyState("k", "P") ? (d*=y_multiplier) : (d:=1)
        GetKeyState("i", "P") ? (u*=y_multiplier) : (u:=1)
        GetKeyState("l", "P") ? (r*=x_multiplier) : (r:=1)
        GetKeyState("j", "P") ? (l*=x_multiplier) : (l:=1)	
        y := (d-u) * distance
        x := (r-l) * distance
        MouseMove, x, y, , R
    #if
}


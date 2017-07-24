push fontName
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 27
call _CreateFontA@56
mov [font], eax

push 1
push dword [font]
push WM_SETFONT
push dword [buttonHandle]
call _SendMessageA@16
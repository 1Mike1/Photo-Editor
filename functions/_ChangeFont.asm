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
push 0
call _CreateFontA@56

push 1
push eax
push WM_SETFONT
push dword [buttonHandle]
call _SendMessageA@16
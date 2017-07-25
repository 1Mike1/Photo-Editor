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
push dword [buttonOpenHandle]
call _SendMessageA@16

push 1
push dword [font]
push WM_SETFONT
push dword [buttonSaveHandle]
call _SendMessageA@16

push 1
push dword [font]
push WM_SETFONT
push dword [buttonBNWHandle]
call _SendMessageA@16

push 1
push dword [font]
push WM_SETFONT
push dword [buttonSepiaHandle]
call _SendMessageA@16

push 1
push dword [font]
push WM_SETFONT
push dword [buttonResetHandle]
call _SendMessageA@16
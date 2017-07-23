mainMessageLoop:
	push dword 0
	push dword 0
	push dword [windowHandle]
	push dword mainMessageStruct
	call _GetMessageA@16
	
	cmp eax,0
	jle _exit

	;push dword mainMessageStruct
	;call [TranslateMessage]
	
	push dword mainMessageStruct
	call _DispatchMessageA@4
	
	jmp mainMessageLoop
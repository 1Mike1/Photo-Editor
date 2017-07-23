mainMessageLoop:
	push dword 0
	push dword 0
	push dword [windowHandle]
	push dword mainMessageStruct
	call _GetMessageA@16
	cmp eax,0
	jle _exit
	
	;push dword 0
	;push dword 0
	;push dword [buttonHandle]
	;push dword buttonMessageStruct
	;call _GetMessageA@16
	
	cmp eax, 0
	jne _nothing
	
	push 0
	push messageTitle
	push messageText
	push 0
	call _MessageBoxA@16
	
_nothing:

	;push dword mainMessageStruct
	;call [TranslateMessage]
	
	push dword buttonMessageStruct
	call _DispatchMessageA@4
	
	push dword mainMessageStruct
	call _DispatchMessageA@4
	
	jmp mainMessageLoop
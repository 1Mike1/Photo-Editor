; Main window procedure
windowProcedure:
	push ebp
	mov ebp,esp
	
	; Window procedure is stdcall convetion, so, 
	; the parameters are located at these kind of offsets.
	; 4 Parameters
	%define ebp_hwnd 	ebp+8
	%define ebp_message ebp+12
	%define ebp_wparam 	ebp+16
	%define ebp_lparam 	ebp+20
	
	; Switch\jump table
	cmp [ebp_message],dword WM_CLOSE
	je .onClose
	cmp [ebp_message],dword WM_DESTROY
	je .onDestroy
	cmp [ebp_message],dword WM_CREATE
	je .onCreate
	cmp [ebp_message], dword WM_COMMAND
	je .onClick
	cmp [ebp_message], dword WM_SIZE
	je .onSize
	
.defaultProcedure:
	push dword [ebp_lparam]
	push dword [ebp_wparam]
	push dword [ebp_message]
	push dword [ebp_hwnd]
	call _DefWindowProcA@16
	mov esp,ebp
	pop ebp
	ret 16 ; stdcall convetion requres pop all parameters from stack 4*4 = 16 bytes
	
.onCreate:
	;push dword SW_SHOW
	;push dword [ebp_hwnd]
	;call _ShowWindow@8
	
	push dword [ebp_hwnd]
	call _UpdateWindow@4
	
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16 ; stdcall convetion requres pop all parameters from stack 4*4 = 16 bytes
	
.onClose:
	push dword [ebp_hwnd]
	call _DestroyWindow@4
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16 ; stdcall convetion requres pop all parameters from stack 4*4 = 16 bytes
	
.onMinimalize:
	push dword 6
	push dword [windowHandle]
	call _ShowWindow@8
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16
	
.onSize:
	push dword buttonOpen
	call CalculateButton
	
	push 0;NULL
	push dword [buttonCalculate + 4*3];Button Size Y
	push dword [buttonCalculate + 4*2];Button Size X
	push dword [buttonCalculate + 4*1];Y
	push dword [buttonCalculate + 4*0];X
	push 0
	push dword [buttonOpenHandle]
	call _SetWindowPos@28
	
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16
	
.onDestroy:
	push dword 0
	call _PostQuitMessage@4
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16 ; stdcall convetion requres pop all parameters from stack 4*4 = 16 bytes
	
.onClick:
	mov ax, [ebp_wparam]
	;and ax, 0x0000FFFF
	cmp ax, [buttonOpen + 4*4]
	je .buttonClick
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16
	
.buttonClick:
	push 0
	push messageTitle
	push messageText
	push 0
	call _MessageBoxA@16
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16
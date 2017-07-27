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
	
.onSize:
	push dword buttonOpen
	call CalculateButton
	push dword buttonOpenHandle
	call SetButtonPosition
	
	push dword buttonSave
	call CalculateButton
	push dword buttonSaveHandle
	call SetButtonPosition
	
	push dword buttonBNW
	call CalculateButton
	push dword buttonBNWHandle
	call SetButtonPosition
	
	push dword buttonSepia
	call CalculateButton
	push dword buttonSepiaHandle
	call SetButtonPosition
	
	push dword buttonReset
	call CalculateButton
	push dword buttonResetHandle
	call SetButtonPosition
	
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
	cmp ax, [buttonOpen + 8*4]
	je .buttonOpenClick
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16
	
.buttonOpenClick:
	push OPENFILENAME
	call _GetOpenFileNameA@4
	cmp eax, 0
	je _null
	
	push 0
	push fileName
	push fileName
	push 0
	call _MessageBoxA@16
	
_null:
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 16
CalculateButton:
	push dword windowPosition
	push dword [windowHandle]
	call _GetWindowRect@8
	
	mov eax, dword [windowPosition + 4*2];Right X
	sub eax, dword [windowPosition + 4*0];Left X
	mov dword [windowSize + 4*0], eax
	;windowSize[0] = Size X
	
	mov eax, dword [windowPosition + 4*3];Bottom Y
	sub eax, dword [windowPosition + 4*1];Top Y
	mov dword [windowSize + 4*1], eax
	;windowSize[1] = Size Y
	
	push ebp
	mov ebp, esp
	mov dword ecx, [ebp + 8]
	
	mov eax, [windowSize + 4*0]
	xor edx, edx
	div dword [windowProportion + 4*0]
	mov ebx, edx
	mul dword [ecx + 4*0]
	add eax, ebx
	sub eax, 15;Why? Life is Mystery
	
	mov dword [buttonCalculate + 4*0], eax;X
	
	mov eax, [windowSize + 4*1]
	xor edx, edx
	div dword [windowProportion + 4*1]
	mov ebx, edx
	mul dword [ecx + 4*1]
	add eax, ebx
	sub eax, 39;Why? Life is Mystery
	
	mov dword [buttonCalculate + 4*1], eax;Y
	
	mov eax, [windowSize + 4*0]
	xor edx, edx
	div dword [windowProportion + 4*0]
	mul dword [ecx + 4*2]
	
	mov dword [buttonCalculate + 4*2], eax;SX
	
	mov eax, [windowSize + 4*1]
	xor edx, edx
	div dword [windowProportion + 4*1]
	mul dword [ecx + 4*3]
	
	mov dword [buttonCalculate + 4*3], eax;SY
	
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 4
	
SetButtonPosition:
	push ebp
	mov ebp, esp
	mov dword ecx, [ebp + 8]

	push 0
	push dword [buttonCalculate + 4*3];Button Size Y
	push dword [buttonCalculate + 4*2];Button Size X
	push dword [buttonCalculate + 4*1];Y
	push dword [buttonCalculate + 4*0];X
	push 0
	push dword [ecx]
	call _SetWindowPos@28
	
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 4
	
CreateButton:
	push ebp
	mov ebp, esp
	mov dword eax, [ebp + 8]
	mov dword ebx, [ebp + 12]

	push dword 0						;LPVOID lpParam 	// pointer to window-creation data
	push dword [hInstance]				;HINSTANCE hInstance,	// handle to application instance
	add eax, 4*4
	push dword [eax]					;HMENU hMenu,	// handle to menu, or child-window identifier
	push dword [windowHandle]			;HWND hWndParent,	// handle to parent or owner window
	push dword [buttonCalculate + 4*3]	;int nHeight,	// window height
	push dword [buttonCalculate + 4*2]	;int nWidth,	// window width
	push dword [buttonCalculate + 4*1]	;int y,	// vertical position of window
	push dword [buttonCalculate + 4*0]	;int x,	// horizontal position of window
	push dword WS_VISIBLECHILD			;DWORD dwStyle,	// window style
	add eax, 4
	push dword eax						;LPCTSTR lpWindowName,	// pointer to window name
	push dword buttonClass				;LPCTSTR lpClassName,	// pointer to registered class name
	push dword 0						;DWORD dwExStyle,	// extended window style
	call _CreateWindowExA@48
	
	mov [ebx], eax
	
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 8
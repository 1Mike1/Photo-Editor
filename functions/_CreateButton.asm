CalculateButton:
	push dword windowPosition
	push dword [windowHandle]
	call _GetWindowRect@8
	
	mov eax, dword [windowPosition + 4*2];Right X
	sub eax, dword [windowPosition + 4*0];Left X
	mov dword [windowSize + 2*0], eax
	;windowSize[4] = Size X
	
	mov eax, dword [windowPosition + 4*3];Bottom Y
	sub eax, dword [windowPosition + 4*1];Top Y
	mov dword [windowSize + 2*1], eax

	;pop ecx;Error TO FIX
	;pop ecx;button
	;pop ebx;buttonCalculate
	
	mov eax, [windowSize + 2*0]
	xor edx, edx
	div dword [windowProportion + 2*0]
	mul dword [buttonOpen + 2*0]
	
	mov dword [buttonCalculate + 2*0], eax;X
	
	mov eax, [windowSize + 2*1]
	xor edx, edx
	div dword [windowProportion + 2*1]
	mul dword [buttonOpen + 2*1]
	
	mov dword [buttonCalculate + 2*1], eax;Y
	
	mov eax, [windowSize + 2*0]
	xor edx, edx
	div dword [windowProportion + 2*0]
	mul dword [buttonOpen + 2*2]
	
	mov dword [buttonCalculate + 2*2], eax;SX
	
	mov eax, [windowSize + 2*1]
	xor edx, edx
	div dword [windowProportion]
	mul dword [buttonOpen + 2*3]
	
	mov dword [buttonCalculate + 2*3], eax;SY
	
	;push buttonOpen + 2*5
	;push buttonCalculate + 2*0
	;push buttonCalculate + 2*1
	;push buttonCalculate + 2*2
	;push buttonCalculate + 2*3
	;push buttonOpen + 2*4
	;jmp CreateButton
	
	;ret
	
CreateButton:
	push dword 0					;LPVOID lpParam 	// pointer to window-creation data
	push dword [hInstance]			;HINSTANCE hInstance,	// handle to application instance
	;pop eax
	push dword [buttonOpen + 2*4]					;HMENU hMenu,	// handle to menu, or child-window identifier
	push dword [windowHandle]		;HWND hWndParent,	// handle to parent or owner window
	;pop dword eax
	push dword [buttonCalculate + 2*3]					;int nHeight,	// window height
	;pop dword eax
	push dword [buttonCalculate + 2*2]					;int nWidth,	// window width
	;pop dword eax
	push dword [buttonCalculate + 2*1]					;int y,	// vertical position of window
	;pop dword eax
	push dword [buttonCalculate + 2*0]					;int x,	// horizontal position of window
	push dword WS_VISIBLECHILD		;DWORD dwStyle,	// window style
	;pop dword eax
	push dword buttonOpen + 2*5					;LPCTSTR lpWindowName,	// pointer to window name
	push dword buttonClass			;LPCTSTR lpClassName,	// pointer to registered class name
	push dword 0					;DWORD dwExStyle,	// extended window style
	call _CreateWindowExA@48
	
	mov [buttonOpenHandle], eax
	ret
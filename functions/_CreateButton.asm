CalculateButton:
	push dword windowPosition
	push dword [windowHandle]
	call _GetWindowRect@8
	
	;mov eax, dword [windowPosition + 4*2];Right X
	;sub eax, dword [windowPosition + 4*0];Left X
	;sub eax, 17;Correction
	;mov dword [windowSize + 4*0], eax
	
	;mov eax, dword [windowPosition + 4*3];Bottom Y
	;sub eax, dword [windowPosition + 4*1];Top Y
	;sub eax, 40;Correction
	;mov dword [windowSize + 4*1], eax
	
	fild dword [windowPosition + 4*2];Right X
	fisub dword [windowPosition + 4*0];Left X
	fisub dword [windowCorrection + 4*0]
	fidiv dword [windowProportion + 4*0]
	fstp qword [windowSize + 8*0]
	;windowSize[0] = Size X
	
	fild dword [windowPosition + 4*3]
	fisub dword [windowPosition + 4*1]
	fisub dword [windowCorrection + 4*1];Bottom Y
	fidiv dword [windowProportion + 4*1];Top Y
	fstp qword [windowSize + 8*1]
	;windowSize[1] = Size Y
	
	push ebp
	mov ebp, esp
	mov dword ecx, [ebp + 8];ButtonCalculate
	
	fld qword [windowSize + 8*0]
	fmul qword [ecx + 8*0]
	frndint
	fistp dword [buttonCalculate + 4*0];X
	
	fld qword [windowSize + 8*1]
	fmul qword [ecx + 8*1]
	frndint
	fistp dword [buttonCalculate + 4*1];Y
	
	fld qword [windowSize + 8*0]
	fmul qword [ecx + 8*2]
	frndint
	fistp dword [buttonCalculate + 4*2];SX
	
	fld qword [windowSize + 8*1]
	fmul qword [ecx + 8*3]
	frndint
	fistp dword [buttonCalculate + 4*3];SY
	
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
	add eax, 8*4
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
	
	push dword 1
	push dword [font]
	push dword WM_SETFONT
	push dword eax
	call _SendMessageA@16
	
	mov eax,0
	mov esp,ebp
	pop ebp
	ret 8
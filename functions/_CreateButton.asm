	push dword 0					;LPVOID lpParam 	// pointer to window-creation data
	push dword [hInstance]			;HINSTANCE hInstance,	// handle to application instance
	push dword [buttonID]			;HMENU hMenu,	// handle to menu, or child-window identifier
	push dword [windowHandle]		;HWND hWndParent,	// handle to parent or owner window
	push dword 100					;int nHeight,	// window height
	push dword 100					;int nWidth,	// window width
	push dword 10					;int y,	// vertical position of window
	push dword 10					;int x,	// horizontal position of window
	push dword WS_VISIBLECHILD				;DWORD dwStyle,	// window style
	push dword buttonText			;LPCTSTR lpWindowName,	// pointer to window name
	push dword buttonClass			;LPCTSTR lpClassName,	// pointer to registered class name
	push dword 0					;DWORD dwExStyle,	// extended window style
	call _CreateWindowExA@48
	mov [buttonHandle], eax
	
	;push dword SW_SHOW
	;push dword [buttonHandle]
	;call _ShowWindow@8
	push dword 0					;LPVOID lpParam 	// pointer to window-creation data
	push dword [hInstance]			;HINSTANCE hInstance,	// handle to application instance
	push dword 0					;HMENU hMenu,	// handle to menu, or child-window identifier
	push dword 0					;HWND hWndParent,	// handle to parent or owner window
	push dword 525					;int nHeight,	// window height
	push dword 785					;int nWidth,	// window width
	push dword 128					;int y,	// vertical position of window
	push dword 128					;int x,	// horizontal position of window
	push dword WS_WINDOWSTYLE		;DWORD dwStyle,	// window style
	push dword mainWindowName		;LPCTSTR lpWindowName,	// pointer to window name
	push dword mainWindowClassName	;LPCTSTR lpClassName,	// pointer to registered class name
	push dword 0					;DWORD dwExStyle,	// extended window style
	call _CreateWindowExA@48
	mov [windowHandle], eax
	;cmp eax,0
	;je createWindowError
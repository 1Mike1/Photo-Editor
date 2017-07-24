global _main

extern  _ExitProcess@4
extern _MessageBoxA@16

extern _GetModuleHandleA@4
extern _RegisterClassExA@4
extern _LoadIconA@8
extern _LoadCursorA@8
extern _CreateWindowExA@48

extern _DefWindowProcA@16
extern _ShowWindow@8
extern _UpdateWindow@4
extern _DestroyWindow@4
extern _PostQuitMessage@4
extern _GetWindowRect@8
extern _SetWindowPos@28

extern _GetMessageA@16
extern _TranslateMessage@4
extern _DispatchMessageA@4

extern _SendMessageA@16
extern _CreateFontA@56

section .bss
	hInstance resb 4
	mainWindowClassEx resb 12*4
	mainMessageStruct resb 7*4
	windowHandle resb 4
	
	windowSize resb 4*4
	
	buttonMessageStruct resb 7*4
	buttonHandle resb 4
	
	font resw 1

section .data
	CS_VREDRAW  equ 0x0001
	CS_HREDRAW  equ 0x0002
	IDI_APPLICATION equ 32512
	COLOR_WINDOW equ 5
	IDC_ARROW equ 32512

	MB_OK  equ 0x00000000
	MB_ICONEXCLAMATION equ 0x00000030

	;WS_SYSMENU  equ 0x00080000
	;WS_SIZEBOX equ 0x00040000
	;WS_MINIMIZEBOX equ 0x00020000
	;WS_MAXIMIZEBOX equ 0x00010000
	WS_WINDOWSTYLE equ 0x100F0000
	;WS_CHILD equ 0x40000000
	;WS_VISIBLE equ 0x10000000
	WS_VISIBLECHILD equ 0x50000000

	SW_SHOW  equ 5

	WM_CREATE equ 0x1
	WM_DESTROY equ 0x2
	WM_CLOSE  equ 0x0010
	WM_COMMAND equ 0x0111
	WM_SIZE equ 0x0005
	
	WM_SETFONT equ 0x0030
	fontName db 'Segoe UI', 0

	mainWindowClassName db 'mainWindow', 0
	mainWindowName db 'Photo Editor', 0
	
	buttonID db 1
	buttonClass db 'BUTTON', 0
	buttonText db 'OK', 0
	
	messageTitle db 'Tytu³', 0
	messageText db 'Tekst', 0

section .text
_main:
	;GetModuleHandle(lpModuleName)
	push 0
	call _GetModuleHandleA@4
	mov [hInstance], eax
	
	;ShowWindow()
	%include "functions/_RegisterClassEx.asm"
	%include "functions/_CreateWindowEx.asm"
	%include "functions/_CreateButton.asm"
	%include "functions/_ChangeFont.asm"
	%include "functions/_MessageLoop.asm"

_exit:
	;ExitProcess(0)
	push 0
	call _ExitProcess@4
	
	%include "functions/_windowProcedure.asm"
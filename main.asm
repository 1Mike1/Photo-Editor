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

extern _GetOpenFileNameA@4

extern _MessageBoxA@16

section .bss
	hInstance resb 4
	mainWindowClassEx resb 12*4
	mainMessageStruct resb 7*4
	windowHandle resb 4
	
	windowPosition resb 4*4
	windowSize resd 2
	
	buttonCalculate resd 4
	
	buttonOpenHandle resb 4
	buttonSaveHandle resb 4
	
	buttonBNWHandle resb 4
	buttonSepiaHandle resb 4
	buttonResetHandle resb 4
	
	font resd 1
	
	fileName resb 260

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
	buttonClass db 'BUTTON', 0
	fontName db 'Segoe UI', 0

	mainWindowClassName db 'mainWindow', 0
	mainWindowName db 'Photo Editor', 0
	
	windowProportion dd 5;SX
					 dd 6;SY
	
	buttonOpen dq 0.0;X
			   dq 5.0;Y
			   dq 2.0;SX
			   dq 1.0;SY
			   dd 1;ID
			   db 'Open', 0;Text
			   
	buttonSave dq 2.0;X
			   dq 5.0;Y
			   dq 2.0;SX
			   dq 1.0;SY
			   dd 2;ID
			   db 'Save', 0;Text
	
	buttonSepia dq 4.0;X
				dq 0.0;Y
				dq 1.0;SX
				dq 1.6666;SY
				dd 3;ID
				db 'Sepia', 0;Text
	
	buttonBNW dq 4.0;X
			  dq 1.6666;Y
			  dq 1.0;SX
			  dq 1.6666;SY
			  dd 4;ID
			  db 'Black and White', 0;Text
				
	buttonReset dq 4.0;X
				dq 3.3332;Y
				dq 1.0;SX
				dq 1.6668;SY
				dd 5;ID
				db 'Reset', 0;Text
	
	messageTitle db 'Tytu³', 0
	messageText db 'Tekst', 0
	
	filter db 'Photo Files (*.jpg; *.jpeg; *.png; *.gif)', 0, '*.jpg;*.jpeg;*.png;*.gif', 0, 0
	OPENFILENAME dd 88;lStructSize
				 dd 0;windowHandle
				 dd 0;hInstance
				 dd filter
				 dd 0
				 dd 0
				 dd 0
				 dd fileName;lpstrFile
				 dd 260;nMaxFile
				 dd 0
				 dd 0
				 dd 0
				 dd 0
				 dd 0
				 dw 0
				 dw 0
				 dd 0
				 dd 0
				 dd 0
				 dd 0
				 dd 0
				 dd 0
				 dd 0

section .text
_main:
	;GetModuleHandle(lpModuleName)
	push 0
	call _GetModuleHandleA@4
	mov [hInstance], eax
	
	mov eax, [windowHandle]
	mov [OPENFILENAME + 4], eax
	
	%include "functions/_CreateFont.asm"
	%include "functions/_RegisterClassEx.asm"
	%include "functions/_CreateWindowEx.asm"
	
	push dword buttonOpen
	call CalculateButton
	push dword buttonOpenHandle
	push dword buttonOpen
	call CreateButton
	
	push dword buttonSave
	call CalculateButton
	push dword buttonSaveHandle
	push dword buttonSave
	call CreateButton
	
	push dword buttonBNW
	call CalculateButton
	push dword buttonBNWHandle
	push dword buttonBNW
	call CreateButton
	
	push dword buttonSepia
	call CalculateButton
	push dword buttonSepiaHandle
	push dword buttonSepia
	call CreateButton
	
	push dword buttonReset
	call CalculateButton
	push dword buttonResetHandle
	push dword buttonReset
	call CreateButton
	
	%include "functions/_MessageLoop.asm"

_exit:
	;ExitProcess(0)
	push 0
	call _ExitProcess@4
	
	%include "functions/_windowProcedure.asm"
	%include "functions/_CreateButton.asm"
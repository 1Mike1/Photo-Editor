all: main.obj resources.o
    gcc -s -mwindows -o PhotoEditor.exe main.obj resources.o
main.o: main.asm
	nasm -fwin32 main.asm
resources.o: Application.manifest resources.rc
	windres resources.rc -o resources.o
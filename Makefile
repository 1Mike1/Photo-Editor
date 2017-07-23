all: main.obj resources.o
	gcc -s -mwindows -o PhotoEditor.exe main.obj resources.o
main.obj: main.asm
	nasm -fwin32 main.asm
resources.o: Application.manifest resources.rc
	windres resources.rc -o resources.o
resources.rc:
	echo "1 24 "Application.manifest"" > resources.rc
clean:
	del main.obj
	del resources.o
	del resources.rc
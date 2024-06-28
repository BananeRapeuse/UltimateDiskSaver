.PHONY: all clean

all: build-ios build-android build-windows build-macos build-linux

build-ios:
	# Commandes pour construire pour iOS

build-android:
	# Commandes pour construire pour Android

build-windows:
	pyinstaller --onefile --noconsole src/main.py --name UltimateDiskSaver.exe

build-macos:
	pyinstaller --onefile --noconsole src/main.py --name UltimateDiskSaver

build-linux:
	pyinstaller --onefile --noconsole src/main.py --name UltimateDiskSaver

clean:
	rm -rf dist build *.spec

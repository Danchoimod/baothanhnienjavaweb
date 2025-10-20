@echo off
echo Cleaning build directories...
if exist build rmdir /s /q build
if exist target rmdir /s /q target
echo Done! Please rebuild your project in Eclipse.
pause

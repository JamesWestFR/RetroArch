@echo off
rem Prepare une cle USB pour RetroArch PS3 (voir Preparer-Cle-USB.ps1).
rem Double-clic : choix de la cle dans la liste. Ou : Preparer-Cle-USB.cmd E:
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Preparer-Cle-USB.ps1" %*
echo.
pause

@echo off
rem Telecharge les jaquettes et images des jeux d'une cle USB RetroArch PS3
rem (voir Telecharger-Images.ps1). Double-clic, ou : Telecharger-Images.cmd E:
rem Autres images : Telecharger-Images.cmd E: -Types boxarts,titles,snaps
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Telecharger-Images.ps1" %*
echo.
pause

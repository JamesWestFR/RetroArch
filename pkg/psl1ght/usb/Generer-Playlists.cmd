@echo off
rem Cree les listes de jeux d'une cle USB RetroArch PS3, une par systeme,
rem avec le bon core par defaut (voir Generer-Playlists.ps1).
rem Double-clic, ou : Generer-Playlists.cmd E:
rem Autre core : Generer-Playlists.cmd E: -Cores gba=vba_next
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Generer-Playlists.ps1" %*
echo.
pause

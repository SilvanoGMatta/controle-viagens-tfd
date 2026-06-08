@echo off
REM Atalho para publicar no GitHub - duplo-clique neste arquivo
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0publicar.ps1" %*

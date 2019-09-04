@echo off
if exist "%~dp0\nicsa" (python "%~dp0\nicsa" %1) else (python "%~dp0\nicsa.py" %1)
if %errorlevel% neq 0 (
echo.
echo [33;1m==================================================
echo Terminated with exit code %errorlevel%
pause
echo [0m
)
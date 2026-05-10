@echo off
cd /d "%~dp0"

rem ============================================================
rem Opens an activated shell for this project only.
rem Use when you actually want an interactive venv session.
rem ============================================================

set "PROJECT_NAME=%~n0"
set "VENV_DIR=.venv"
set "ACTIVATE=%CD%\%VENV_DIR%\Scripts\activate.bat"

if not exist "%ACTIVATE%" (
    echo [ERROR] Local venv was not found:
    echo         %ACTIVATE%
    echo.
    echo Create it with:
    echo         python -m venv %VENV_DIR%
    echo.
    pause
    exit /b 1
)

title %PROJECT_NAME% - VENV SHELL
call "%ACTIVATE%"

echo ============================================================
echo Activated project shell
echo Project: %CD%
echo Python :
where python
echo ============================================================
echo.
cmd /k

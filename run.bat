@echo off
setlocal
cd /d "%~dp0"

rem ============================================================
rem Project Runner Template
rem Edit APP_ENTRY to your actual launcher file.
rem Examples:
rem   set "APP_ENTRY=main.py"
rem   set "APP_ENTRY=app.py"
rem   set "APP_ENTRY=devtoolkit.py"
rem   set "APP_ENTRY=src\main.py"
rem ============================================================

set "PROJECT_NAME=%~n0"
set "VENV_DIR=.venv"
set "APP_ENTRY=main.py"

set "PY=%CD%\%VENV_DIR%\Scripts\python.exe"

if not exist "%PY%" (
    echo [ERROR] Local venv was not found:
    echo         %PY%
    echo.
    echo Create it with:
    echo         python -m venv %VENV_DIR%
    echo         %VENV_DIR%\Scripts\python.exe -m pip install --upgrade pip
    echo         %VENV_DIR%\Scripts\python.exe -m pip install -r requirements.txt
    echo.
    pause
    exit /b 1
)

if not exist "%APP_ENTRY%" (
    echo [ERROR] APP_ENTRY does not exist:
    echo         %APP_ENTRY%
    echo.
    echo Edit run.bat and set APP_ENTRY to your real launcher file.
    echo.
    pause
    exit /b 1
)

title %PROJECT_NAME% - RUN
echo ============================================================
echo Running: %PROJECT_NAME%
echo Project: %CD%
echo Python : %PY%
echo Entry  : %APP_ENTRY%
echo ============================================================
echo.

"%PY%" "%APP_ENTRY%" %*

set "EXITCODE=%ERRORLEVEL%"
echo.
echo ============================================================
echo Process exited with code: %EXITCODE%
echo ============================================================
pause
exit /b %EXITCODE%

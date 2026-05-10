@echo off
setlocal
cd /d "%~dp0"

rem ============================================================
rem Project environment doctor
rem Checks:
rem   - local venv exists
rem   - exact python executable
rem   - pip version
rem   - optional requirements check
rem   - optional PyQt6 WebEngine check
rem ============================================================

set "VENV_DIR=.venv"
set "PY=%CD%\%VENV_DIR%\Scripts\python.exe"

echo ============================================================
echo PROJECT DOCTOR
echo ============================================================
echo Project: %CD%
echo.

if not exist "%PY%" (
    echo [FAIL] Local venv was not found:
    echo        %PY%
    echo.
    echo Create it with:
    echo        python -m venv %VENV_DIR%
    echo        %VENV_DIR%\Scripts\python.exe -m pip install --upgrade pip
    echo.
    pause
    exit /b 1
)

echo [OK] Local venv found:
echo      %PY%
echo.

echo ------------------------------------------------------------
echo Python identity
echo ------------------------------------------------------------
"%PY%" -c "import sys; print('executable:', sys.executable); print('prefix    :', sys.prefix); print('version   :', sys.version)"
echo.

echo ------------------------------------------------------------
echo Pip version
echo ------------------------------------------------------------
"%PY%" -m pip --version
echo.

echo ------------------------------------------------------------
echo Pip dependency check
echo ------------------------------------------------------------
"%PY%" -m pip check
echo.

echo ------------------------------------------------------------
echo Requirements file check
echo ------------------------------------------------------------
if exist "requirements.txt" (
    echo [OK] requirements.txt found.
) else (
    echo [WARN] requirements.txt not found.
)
if exist "requirements.lock.txt" (
    echo [OK] requirements.lock.txt found.
) else (
    echo [WARN] requirements.lock.txt not found.
)
echo.

echo ------------------------------------------------------------
echo Optional PyQt6 WebEngine check
echo ------------------------------------------------------------
"%PY%" -c "from PyQt6 import QtCore; print('PyQt:', QtCore.PYQT_VERSION_STR); print('Qt   :', QtCore.QT_VERSION_STR); from PyQt6.QtWebEngineWidgets import QWebEngineView; print('WEBENGINE OK')" 2>nul
if errorlevel 1 (
    echo [INFO] PyQt6 WebEngine not available or not required for this project.
) else (
    echo [OK] PyQt6 WebEngine import succeeded.
)

echo.
echo ============================================================
echo DOCTOR COMPLETE
echo ============================================================
pause
exit /b 0

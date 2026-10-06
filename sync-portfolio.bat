@echo off
setlocal enabledelayedexpansion

echo ========================================================
echo         Shijin P S Portfolio - GitHub Auto-Sync
echo ========================================================
echo.

cd /d "%~dp0"

echo [1/3] Checking for git changes...
git status --short

set /p COMMIT_MSG="Enter commit message (Press Enter for default): "
if "%COMMIT_MSG%"=="" (
    set COMMIT_MSG=Update portfolio - %DATE% %TIME%
)

echo.
echo [2/3] Staging and committing changes...
git add -A
git commit -m "%COMMIT_MSG%"

echo.
echo [3/3] Pushing to GitHub (origin/main)...
git push origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================================
    echo  SUCCESS: Portfolio successfully updated on GitHub!
    echo ========================================================
) else (
    echo.
    echo ========================================================
    echo  NOTICE: Push did not complete. If you have not logged
    echo  in to GitHub yet, please sign in when prompted.
    echo ========================================================
)

echo.
pause

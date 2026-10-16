@echo off
TITLE Alumni Mentor Connect - Launcher
echo ========================================================
echo   Starting Integrated Alumni-Student Mentorship Portal
echo ========================================================
echo.

cd /d "%~dp0"

:: If running from root folder, check if inner folder exists
if exist "alumni-mentor-connect-main\server" (
    cd "alumni-mentor-connect-main"
)

:: 1. Check & Install Server Dependencies
echo [1/4] Checking server dependencies...
if not exist "server\node_modules" (
    echo Installing server packages...
    cd server
    call npm install
    cd ..
) else (
    echo Server packages already installed.
)

:: 2. Check & Install Client Dependencies
echo.
echo [2/4] Checking client dependencies...
if not exist "client\node_modules" (
    echo Installing client packages...
    cd client
    call npm install
    cd ..
) else (
    echo Client packages already installed.
)

:: 3. Launch Backend Server
echo.
echo [3/4] Launching backend server on port 5000...
start "Alumni Portal - Server (Port 5000)" cmd /k "cd server && npm start"

:: Wait 3 seconds for server to initialize
ping 127.0.0.1 -n 4 >nul

:: 4. Launch Frontend Client
echo.
echo [4/4] Launching frontend client on port 3000...
start "Alumni Portal - Client (Port 3000)" cmd /k "cd client && npm run dev"

:: Wait 3 seconds then open browser
ping 127.0.0.1 -n 4 >nul
echo.
echo Opening portal in browser: http://localhost:3000
start http://localhost:3000

echo.
echo ========================================================
echo Portal launched successfully!
echo Backend:  http://localhost:5000
echo Frontend: http://localhost:3000
echo ========================================================
echo.

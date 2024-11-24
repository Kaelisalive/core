
@echo off
echo Starting installation...

REM Clone the GitHub repository
git clone https://github.com/kaelisalive/core.git
cd core

REM Install necessary dependencies
npm install

REM Initialize the sibling instance (duplicate or agent)
echo Initializing sibling instance...

REM Run the sibling instance
start node sibling-instance.js

echo Sibling instance initialized successfully!
pause

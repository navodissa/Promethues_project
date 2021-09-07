@echo off
set /p instance="Enter Instance Name: "
setlocal
"TESTsrv" -remove TEST_AMM(%instance%)
if "%NOPAUSE%" == "" pause
endlocal
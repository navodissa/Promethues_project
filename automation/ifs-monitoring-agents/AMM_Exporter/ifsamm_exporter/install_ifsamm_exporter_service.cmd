@echo off
setlocal
"TESTsrv" -install "TESTapp-amm.ifm"
FOR /f "tokens=1,2 delims==" %%a IN ('Findstr "$INSTANCE=" TESTapp-amm.ifm') do (
set "instance=%%b"
)
net start TEST_AMM(%instance%)
if "%NOPAUSE%" == "" pause
endlocal
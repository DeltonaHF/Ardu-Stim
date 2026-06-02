@echo off
if "%~1"=="" (
    echo Error: COM port not specified.
    echo Usage: %~nx0 COMx
    pause
    exit /b 1
)

set "COM=%~1"

if not exist "backup_hex\" mkdir "backup_hex\"

for /f %%T in ('powershell -NoProfile -Command "[datetime]::Now.ToString('yyyyMMdd_HHmmss')"') do set "TIMESTAMP=%%T"

set "OUTFILE=backup_hex\backup_flash_%TIMESTAMP%.hex"

echo Reading flash from %COM% to %OUTFILE%...
avrdude -c arduino -p atmega328p -P %COM% -b 57600 -U flash:r:%OUTFILE%:i

if errorlevel 1 (
    echo avrdude failed.
    pause
    exit /b 1
)

echo Done: %OUTFILE%
pause
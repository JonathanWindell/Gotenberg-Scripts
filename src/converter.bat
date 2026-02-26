@echo off
chcp 65001 >nul
:: Ensure that å, ä, ö & symbols are shown correcly in window

echo =====================================================
echo   GOTENBERG MASS-Converter
echo =====================================================
echo.

:: Asks user for IP adress & port to Gotenberg
set /p USER_URL="Enter your IP address and port to Gotenberg (Example: 192.168.X.X:3000): "

:: 1: Configuration
set GOTENBERG_URL="http://%USER_URL%/libreoffice/convert"

:: 2: Interactive Input
set /p SOURCE_DIR="Folder with original files (Example: C:\My-Documents): "
if not exist "%SOURCE_DIR%" (
    echo [ERROR] Folder "%SOURCE_DIR%" was not found.
    pause
    exit /b
)

set /p FILE_EXT="Which file type should be converted? (Example: odt, docx): "
:: Delete . if user enters by mistake .odt
set FILE_EXT=%FILE_EXT:.=%

set /p TARGET_DIR="Folder for finished PDF:s (Example C:\Converted-PDF:s): "
:: If target map does not exist. Create
if not exist "%TARGET_DIR%" (
    echo Ceate target folder...
    mkdir "%TARGET_DIR%"
)

echo.
echo Executing converting!
echo -----------------------------------------------------

set COUNT=0
set SUCCESS=0

:: Conversion Loop
for %%F in ("%SOURCE_DIR%\*.%FILE_EXT%") do (
    set /a COUNT+=1
    echo Sending %%~nxF to Gotenberg
    
    :: Sending files using curl
    curl.exe -s -o "%TARGET_DIR%\%%~nF.pdf" --request POST %GOTENBERG_URL% --form "files=@"%%F""
    
    :: Control if file was created
    if exist "%TARGET_DIR%\%%~nF.pdf" (
        set /a SUCCESS+=1
        echo  -^> [ Finished ]
    ) else (
        echo  -^> [ Error ]
    )
)

echo -----------------------------------------------------
if %COUNT%==0 (
    echo Found no files of type %FILE_EXT% i %SOURCE_DIR%.
) else (
    echo Finished! Converted %SUCCESS% av %COUNT% files.
    echo Your converted PDF:s wait in: %TARGET_DIR%
)
echo.
pause
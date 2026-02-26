@echo off
:: Enable delayed expansion to update variables (like counters) inside the FOR loop
setlocal enabledelayedexpansion
:: Set character encoding to UTF-8 to handle special characters (å, ä, ö)
chcp 65001 >nul

echo =====================================================
echo    GOTENBERG BATCH CONVERTER
echo =====================================================
echo.

:: 1. User Input for Connection
:: Asks for the IP and Port where the Gotenberg Docker container is hosted
set /p USER_URL="Enter Gotenberg IP and Port (e.g., 192.168.0.54:3000): "

:: 2. Endpoint Configuration
:: Defines the specific API endpoint for LibreOffice conversions
:: Note: The /forms/ prefix is required for newer Gotenberg versions
set GOTENBERG_URL=http://%USER_URL%/forms/libreoffice/convert

:: 3. Directory Configuration
:: Get the source folder and verify its existence
set /p SOURCE_DIR="Enter source folder path: "
if not exist "%SOURCE_DIR%" (
    echo [ERROR] The directory "%SOURCE_DIR%" does not exist.
    pause
    exit /b
)

:: Get file extension and strip any leading dots provided by the user
set /p FILE_EXT="Enter file extension to convert (e.g., docx, odt): "
set FILE_EXT=%FILE_EXT:.=%

:: Get or create the output directory
set /p TARGET_DIR="Enter target folder for PDFs: "
if not exist "%TARGET_DIR%" (
    echo Creating target folder...
    mkdir "%TARGET_DIR%"
)

echo.
echo Starting conversion process...
echo -----------------------------------------------------

:: Initialize counters
set COUNT=0
set SUCCESS=0

:: 4. Conversion Loop
:: Iterates through all files matching the specified extension in the source folder
for %%F in ("%SOURCE_DIR%\*.%FILE_EXT%") do (
    set /a COUNT+=1
    echo Processing: %%~nxF
    
    :: Execute the conversion using Curl
    :: -s: Silent mode (hides progress bar)
    :: -o: Output file path
    :: --form: Sends the file using the 'files' field name expected by Gotenberg
    curl.exe -s -o "%TARGET_DIR%\%%~nF.pdf" --request POST "%GOTENBERG_URL%" --form "files=@%%F"
    
    :: 5. Verification
    :: Checks if the PDF was successfully created in the target folder
    if exist "%TARGET_DIR%\%%~nF.pdf" (
        set /a SUCCESS+=1
        echo   [SUCCESS] File converted.
    ) else (
        echo   [ERROR] Failed to convert %%~nxF.
    )
)

:: 6. Final Report
echo -----------------------------------------------------
if %COUNT%==0 (
    echo No files with extension .%FILE_EXT% were found in the source folder.
) else (
    echo Summary: Successfully converted !SUCCESS! out of !COUNT! files.
    echo Location: %TARGET_DIR%
)
echo.

pause
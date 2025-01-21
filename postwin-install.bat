@echo off
NET SESSION >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as Administrator.
    pause
    exit /b
)

echo Starting automated software installation...

set "office_installer=MicrosoftOffice2021Setup.exe"
set "adobe_installer=AdobeReaderInstaller.exe"
set "chrome_installer=https://dl.google.com/chrome/install/latest/chrome_installer.exe"
set "zoho_installer=ZohoAssistantSetup.exe"

if exist "%office_installer%" (
    echo Installing Microsoft Office 2021...
    "%office_installer%" /quiet /norestart
    echo Microsoft Office 2021 installation completed.
) else (
    echo Microsoft Office 2021 installer not found! Skipping...
)

if exist "%adobe_installer%" (
    echo Installing Adobe Reader...
    "%adobe_installer%" /sAll /msi /norestart
    echo Adobe Reader installation completed.
) else (
    echo Adobe Reader installer not found! Skipping...
)

echo Installing Google Chrome...
start /wait msiexec /i "%chrome_installer%" /quiet /norestart
echo Google Chrome installation completed.

if exist "%zoho_installer%" (
    echo Installing Zoho Assistant...
    "%zoho_installer%" /quiet /norestart
    echo Zoho Assistant installation completed.
) else (
    echo Zoho Assistant installer not found! Skipping...
)

echo All installations completed. Please check logs for any errors.
pause

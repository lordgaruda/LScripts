if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script must be run as an administrator." -ForegroundColor Red
    exit
}

if (-not (Get-Module -Name GroupPolicy -ListAvailable)) {
    Write-Host "The GroupPolicy module is not available. Please install RSAT: Group Policy Management tools." -ForegroundColor Red
    exit
}
Import-Module GroupPolicy

$GPOName = Read-Host "Enter the name for the new GPO (e.g., Restrict USB Removable Storage)"
$DomainName = Read-Host "Enter the domain name (e.g., yourdomain.com)"
$OULocation = Read-Host "Enter the OU path where the GPO should be linked (e.g., OU=YourOUName,DC=yourdomain,DC=com)"

try {
    $GPO = New-GPO -Name $GPOName -ErrorAction Stop
} catch {
    Write-Host "Failed to create GPO: $_" -ForegroundColor Red
    exit
}

Set-GPRegistryValue -Name $GPOName -Key "HKLM\Software\Policies\Microsoft\Windows\RemovableStorageDevices" -ValueName "*:Deny_All" -Type DWord -Value 1

try {
    New-GPLink -Name $GPOName -Target $OULocation -Enforced Yes
} catch {
    Write-Host "Failed to link GPO: $_" -ForegroundColor Red
    exit
}

Invoke-Command -ScriptBlock { gpupdate /force } -ErrorAction SilentlyContinue

Write-Host "USB removable storage restriction has been successfully configured and applied." -ForegroundColor Green

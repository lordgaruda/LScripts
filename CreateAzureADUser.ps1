if (-not (Get-Module -ListAvailable -Name AzureAD)) {
    Install-Module -Name AzureAD -Force -Scope CurrentUser
}

Connect-AzureAD

$UserPrincipalName = Read-Host "Enter User Principal Name (e.g., user@domain.com)"
$DisplayName = Read-Host "Enter Display Name (e.g., John Doe)"
$MailNickname = Read-Host "Enter Mail Nickname (e.g., johndoe)"
$Password = Read-Host "Enter Password (must meet Azure AD complexity requirements)"
$ForcePasswordChange = Read-Host "Force password change on first login? (yes/no)"
$ForcePasswordChangeBool = if ($ForcePasswordChange -eq "yes") { $true } else { $false }
$AccountEnabled = Read-Host "Enable account immediately? (yes/no)"
$AccountEnabledBool = if ($AccountEnabled -eq "yes") { $true } else { $false }

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = $Password
$PasswordProfile.ForceChangePasswordNextLogin = $ForcePasswordChangeBool

try {
    New-AzureADUser -UserPrincipalName $UserPrincipalName `
                    -DisplayName $DisplayName `
                    -MailNickname $MailNickname `
                    -PasswordProfile $PasswordProfile `
                    -AccountEnabled $AccountEnabledBool
    Write-Host "User created successfully!" -ForegroundColor Green
} catch {
    Write-Host "Error creating user: $_" -ForegroundColor Red
}

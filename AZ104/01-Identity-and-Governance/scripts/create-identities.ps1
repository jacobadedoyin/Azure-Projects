# 1. Create Group (Only if it doesn't exist)
$groupName = "IT-Admins"
$existingGroup = Get-AzADGroup -DisplayName $groupName -ErrorAction SilentlyContinue

if ($null -eq $existingGroup) {
    Write-Host "Group '$groupName' not found. Creating it..." -ForegroundColor Cyan
    New-AzADGroup -DisplayName $groupName -MailNickname "itadmins" -SecurityEnabled
} else {
    Write-Host "Group '$groupName' already exists. Skipping creation." -ForegroundColor Yellow
}

# 2. Create User (Only if it doesn't exist)
$userUPN = "labadmin@jacobadedoyingriffithsgmail.onmicrosoft.com"
$existingUser = Get-AzADUser -UserPrincipalName $userUPN -ErrorAction SilentlyContinue

if ($null -eq $existingUser) {
    Write-Host "User '$userUPN' not found. Creating it..." -ForegroundColor Cyan
    $passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $passwordProfile.Password = "Pa55w0rd123!"
    New-AzADUser -DisplayName "Lab Admin" -PasswordProfile $passwordProfile -UserPrincipalName $userUPN -AccountEnabled -MailNickname "labadmin"
} else {
    Write-Host "User '$userUPN' already exists. Skipping creation." -ForegroundColor Yellow
}

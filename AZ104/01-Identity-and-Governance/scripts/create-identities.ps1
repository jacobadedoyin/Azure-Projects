param (
    [string]$GroupName,
    [string]$UserUPN,
    [string]$UserDisplay
)

Write-Host "`n--- Starting Deployment ---" -ForegroundColor Cyan

# 1. Group (Only creates if it can't find it)
if (-not (Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue)) {
    Write-Host "[+] Creating Group: $GroupName"
    New-AzADGroup -DisplayName $GroupName -MailNickname "itadmins" -SecurityEnabled | Out-Null
}

# 2. User (Only creates if it can't find it)
if (-not (Get-AzADUser -UserPrincipalName $UserUPN -ErrorAction SilentlyContinue)) {
    Write-Host "[+] Creating User: $UserUPN"
    $pass = @{Password="Pa55w0rd123!"; ForceChangePasswordNextLogin=$false}
    New-AzADUser -DisplayName $UserDisplay -UserPrincipalName $UserUPN -PasswordProfile $pass -AccountEnabled $true -MailNickname "labadmin" | Out-Null
}

# 3. The Link (Using the exact parameters you want)
Write-Host "[*] Linking $UserUPN to $GroupName..."
Add-AzADGroupMember -TargetGroupDisplayName $GroupName -MemberUserPrincipalName $UserUPN -ErrorAction SilentlyContinue

Write-Host "--- Deployment Complete ---`n" -ForegroundColor Green

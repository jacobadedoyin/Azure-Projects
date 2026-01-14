param (
    [Parameter(Mandatory=$true)]
    [string]$GroupName,

    [Parameter(Mandatory=$true)]
    [string]$UserUPN,

    [string]$UserDisplay = "Lab Admin"
)

Write-Host "`n--- Starting Identity Deployment ---" -ForegroundColor Cyan

# 1. Check Group (Picks the first one if duplicates exist)
$targetGroup = Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $targetGroup) {
    Write-Host "[+] Creating Group: $GroupName" -ForegroundColor Green
    New-AzADGroup -DisplayName $GroupName -MailNickname "itadmins" -SecurityEnabled | Out-Null
}

# 2. Check User
if (-not (Get-AzADUser -UserPrincipalName $UserUPN -ErrorAction SilentlyContinue)) {
    Write-Host "[+] Creating User: $UserUPN" -ForegroundColor Green
    $pass = @{Password="Pa55w0rd123!"; ForceChangePasswordNextLogin=$false}
    New-AzADUser -DisplayName $UserDisplay -UserPrincipalName $UserUPN -AccountEnabled $true -MailNickname "labadmin" -PasswordProfile $pass | Out-Null
}

# 3. The Link (No try/catch, just direct command)
Write-Host "[*] Synchronizing Membership..."
Add-AzADGroupMember -TargetGroupDisplayName $GroupName -MemberUserPrincipalName $UserUPN -ErrorAction SilentlyContinue

Write-Host "[✔] Deployment Complete!" -ForegroundColor Green

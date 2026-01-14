param (
    [Parameter(Mandatory=$true)]
    [string]$GroupName,

    [Parameter(Mandatory=$true)]
    [string]$UserUPN,

    [string]$UserDisplay = "Lab Admin"
)

Write-Host "`n--- Starting Identity Deployment ---" -ForegroundColor Cyan

# 1. Check Group
if (-not (Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue)) {
    Write-Host "[+] Creating Group: $GroupName"
    New-AzADGroup -DisplayName $GroupName -MailNickname "itadmins" -SecurityEnabled | Out-Null
}

# 2. Check User
if (-not (Get-AzADUser -UserPrincipalName $UserUPN -ErrorAction SilentlyContinue)) {
    Write-Host "[+] Creating User: $UserUPN"
    New-AzADUser -DisplayName $UserDisplay -UserPrincipalName $UserUPN -AccountEnabled $true -MailNickname "labadmin" -PasswordProfile @{Password="Pa55w0rd123!"} | Out-Null
}

# 3. The Link (This uses the strings you pass via CLI)
Write-Host "[*] Synchronizing Membership..."
Add-AzADGroupMember -TargetGroupDisplayName $GroupName -MemberUserPrincipalName $UserUPN -ErrorAction SilentlyContinue

Write-Host "[✔] Deployment Complete!" -ForegroundColor Green

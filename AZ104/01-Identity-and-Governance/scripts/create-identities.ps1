param (
    [Parameter(Mandatory=$true)]
    [string]$GroupName,

    [Parameter(Mandatory=$true)]
    [string]$UserUPN,

    [Parameter(Mandatory=$false)]
    [string]$UserDisplay = "Lab Admin"
)

Write-Host "`n--- Starting Identity Deployment ---" -ForegroundColor Cyan

# 1. Ensure Group Exists (Picks the first one if duplicates exist)
$targetGroup = Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $targetGroup) {
    Write-Host "[+] Creating Group: $GroupName" -ForegroundColor Green
    New-AzADGroup -DisplayName $GroupName -MailNickname ($GroupName -replace " ","") -SecurityEnabled | Out-Null
}

# 2. Ensure User Exists
if (-not (Get-AzADUser -UserPrincipalName $UserUPN -ErrorAction SilentlyContinue)) {
    Write-Host "[+] Creating User: $UserUPN" -ForegroundColor Green
    New-AzADUser -DisplayName $UserDisplay -UserPrincipalName $UserUPN -AccountEnabled $true -MailNickname "labadmin" -PasswordProfile @{Password="Pa55w0rd123!"} | Out-Null
}

# 3. Link them using the CLI-safe command
Write-Host "[*] Synchronizing Membership..." -ForegroundColor Cyan
# We use -ErrorAction SilentlyContinue because if they are already linked, we don't care
Add-AzADGroupMember -TargetGroupDisplayName $GroupName -MemberUserPrincipalName $UserUPN -ErrorAction SilentlyContinue

Write-Host "[✔] Deployment Complete ---`n" -ForegroundColor Green

<#
.SYNOPSIS
    AZ-104 Lab 01: Automated Identity Creation.
#>

param (
    [string]$GroupName = "IT-Admins",
    [string]$UserUPN = "labadmin@jacobadedoyingriffithsgmail.onmicrosoft.com",
    [string]$UserDisplay = "Lab Admin"
)

process {
    Write-Host "`n--- Starting Identity Deployment ---" -ForegroundColor Cyan

    # 1. CLEANUP DUPLICATES
    $existingGroups = Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue
    if ($existingGroups.Count -gt 1) {
        Write-Host "[!] Found $($existingGroups.Count) duplicate groups. Cleaning up..." -ForegroundColor Yellow
        $existingGroups | Select-Object -Skip 1 | ForEach-Object { Remove-AzADGroup -ObjectId $_.Id }
    }

    # 2. GROUP MANAGEMENT
    $targetGroup = Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $targetGroup) {
        Write-Host "[+] Creating Security Group: $GroupName" -ForegroundColor Green
        New-AzADGroup -DisplayName $GroupName -MailNickname ($GroupName -replace " ","") -SecurityEnabled | Out-Null
    } else {
        Write-Host "[i] Group '$GroupName' already exists." -ForegroundColor Gray
    }

    # 3. USER MANAGEMENT
    $targetUser = Get-AzADUser -UserPrincipalName $UserUPN -ErrorAction SilentlyContinue
    if (-not $targetUser) {
        Write-Host "[+] Creating User: $UserUPN" -ForegroundColor Green
        New-AzADUser -DisplayName $UserDisplay `
                     -PasswordProfile @{Password="Pa55w0rd123!"; ForceChangePasswordNextLogin=$false} `
                     -UserPrincipalName $UserUPN `
                     -AccountEnabled $true `
                     -MailNickname "labadmin" | Out-Null
    } else {
        Write-Host "[i] User '$UserUPN' already exists." -ForegroundColor Gray
    }

    # 4. MEMBERSHIP MANAGEMENT (The 'No-Nonsense' Fix)
    Write-Host "[*] Synchronizing Membership..." -ForegroundColor Cyan
    try {
        # This is the EXACT line that worked in your terminal earlier
        Add-AzADGroupMember -TargetGroupDisplayName $GroupName -MemberUserPrincipalName $UserUPN -ErrorAction Stop
        Write-Host "[✔] User successfully linked to Group." -ForegroundColor Green
    } catch {
        # If the user is already there, it throws an error, so we catch it here
        if ($_.Exception.Message -like "*already exists*") {
            Write-Host "[i] User is already a member." -ForegroundColor Gray
        } else {
            Write-Host "[✘] Error: $($_.Exception.Message)" -ForegroundColor Red
        }
    }

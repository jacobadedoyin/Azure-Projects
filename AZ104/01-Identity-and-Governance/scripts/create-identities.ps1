<#
.SYNOPSIS
    AZ-104 Lab 01: Automated Identity Creation.
.DESCRIPTION
    Creates a security group and a user, then links them. 
    Includes idempotency checks to prevent duplicate resources.
#>

param (
    [Parameter(Mandatory=$false)]
    [string]$GroupName = "IT-Admins",

    [Parameter(Mandatory=$false)]
    [string]$UserUPN = "labadmin@jacobadedoyingriffithsgmail.onmicrosoft.com",

    [Parameter(Mandatory=$false)]
    [string]$UserDisplay = "Lab Admin"
)

process {
    Write-Host "`n--- Starting Identity Deployment ---" -ForegroundColor Cyan

    # 1. CLEANUP DUPLICATES (Pro move: ensuring a clean state)
    $existingGroups = Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue
    if ($existingGroups.Count -gt 1) {
        Write-Host "[!] Found $($existingGroups.Count) duplicate groups. Cleaning up..." -ForegroundColor Yellow
        $existingGroups | Select-Object -Skip 1 | ForEach-Object { Remove-AzADGroup -ObjectId $_.Id }
    }

    # 2. GROUP MANAGEMENT
    $targetGroup = Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $targetGroup) {
        Write-Host "[+] Creating Security Group: $GroupName" -ForegroundColor Green
        $targetGroup = New-AzADGroup -DisplayName $GroupName -MailNickname ($GroupName -replace " ","") -SecurityEnabled
    } else {
        Write-Host "[i] Group '$GroupName' already exists." -ForegroundColor Gray
    }

    # 3. USER MANAGEMENT
    $targetUser = Get-AzADUser -UserPrincipalName $UserUPN -ErrorAction SilentlyContinue
    if (-not $targetUser) {
        Write-Host "[+] Creating User: $UserUPN" -ForegroundColor Green
        $securePassword = ConvertTo-SecureString "Pa55w0rd123!" -AsPlainText -Force
        $targetUser = New-AzADUser -DisplayName $UserDisplay `
                                   -PasswordProfile @{Password="Pa55w0rd123!"; ForceChangePasswordNextLogin=$false} `
                                   -UserPrincipalName $UserUPN `
                                   -AccountEnabled $true `
                                   -MailNickname "labadmin"
    } else {
        Write-Host "[i] User '$UserUPN' already exists." -ForegroundColor Gray
    }

    # 4. MEMBERSHIP MANAGEMENT (The 'Surgical' Fix)
    Write-Host "[*] Synchronizing Membership..." -ForegroundColor Cyan
    try {
        # Check if already a member to avoid errors
        $isMember = Get-AzADGroupMember -GroupObjectId $targetGroup.Id | Where-Object { $_.Id -eq $targetUser.Id }
        if (-not $isMember) {
            Add-AzADGroupMember -TargetGroupId $targetGroup.Id -MemberId $targetUser.Id -ErrorAction Stop
            Write-Host "[✔] User successfully added to Group." -ForegroundColor Green
        } else {
            Write-Host "[i] User is already a member of the group." -ForegroundColor Gray
        }
    } catch {
        Write-Host "[✘] Failed to link user. You may need to add them via the Azure Portal." -ForegroundColor Red
        Write-Debug $_.Exception.Message
    }

    Write-Host "--- Deployment Complete ---`n" -ForegroundColor Cyan
}

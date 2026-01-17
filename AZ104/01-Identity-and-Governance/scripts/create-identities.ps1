<#
.SYNOPSIS
    Automates the lifecycle of Entra ID (Azure AD) users and groups for lab environments.
.DESCRIPTION
    Ensures the specified Group and User exist, and that the User is a member of the Group.
    Designed to be idempotent (safe to run multiple times).
.PARAMETER GroupName
    The display name of the security group (e.g., 'IT-Admins').
.PARAMETER UserUPN
    The full User Principal Name (e.g., 'admin@<yourtenant>.onmicrosoft.com').
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$GroupName,

    [Parameter(Mandatory=$true)]
    [string]$UserUPN,

    [string]$UserDisplay = "Lab Admin"
)

# Standardize output colors for readability
$ColorInfo = "Cyan"
$ColorSuccess = "Green"
$ColorWarn = "Yellow"

Write-Host "`n--- ☁️ Starting Identity Deployment ---" -ForegroundColor $ColorInfo

# --- 1. Group Management ---
$targetGroup = Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue | Select-Object -First 1

if ($targetGroup) {
    Write-Host "   [=] Group '$GroupName' already exists. (ID: $($targetGroup.Id))" -ForegroundColor $ColorWarn
}
else {
    Write-Host "   [+] Creating Group: '$GroupName'..." -ForegroundColor $ColorInfo
    $targetGroup = New-AzADGroup -DisplayName $GroupName -MailNickname ($GroupName -replace " ","") -SecurityEnabled
    Write-Host "   [✔] Group Created." -ForegroundColor $ColorSuccess
}

# --- 2. User Management ---
$targetUser = Get-AzADUser -UserPrincipalName $UserUPN -ErrorAction SilentlyContinue

if ($targetUser) {
    Write-Host "   [=] User '$UserUPN' already exists. (ID: $($targetUser.Id))" -ForegroundColor $ColorWarn
}
else {
    Write-Host "   [+] Creating User: '$UserUPN'..." -ForegroundColor $ColorInfo
    
    # Generate a temporary password profile
    # NOTE: In production, use KeyVault or a randomized secret.
    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = "Init!alP@ss123" 
    $PasswordProfile.ForceChangePasswordNextLogin = $true

    $targetUser = New-AzADUser -DisplayName $UserDisplay `
                               -UserPrincipalName $UserUPN `
                               -AccountEnabled $true `
                               -MailNickname ($UserUPN.Split("@")[0]) `
                               -PasswordProfile $PasswordProfile
    
    Write-Host "   [✔] User Created." -ForegroundColor $ColorSuccess
}

# --- 3. Membership Association (The "Link") ---
# We check membership first to ensure the script is "Idempotent" (doesn't error on re-runs)
$isMember = Get-AzADGroupMember -GroupDisplayName $GroupName | Where-Object { $_.Id -eq $targetUser.Id }

if ($isMember) {
    Write-Host "   [=] User is already a member of '$GroupName'." -ForegroundColor $ColorWarn
}
else {
    Write-Host "   [*] Adding User to Group..." -ForegroundColor $ColorInfo
    try {
        # Using Object IDs is safer than Display Names
        Add-AzADGroupMember -TargetGroupObjectId $targetGroup.Id -MemberObjectId $targetUser.Id -ErrorAction Stop
        Write-Host "   [✔] Membership Synchronized." -ForegroundColor $ColorSuccess
    }
    catch {
        Write-Error "   [X] Failed to add member: $_"
    }
}

Write-Host "`n--- Deployment Complete ---" -ForegroundColor $ColorInfo

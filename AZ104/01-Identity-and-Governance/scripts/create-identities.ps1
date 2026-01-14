# 1. Create the Security Group
$groupName = "IT-Admins"

# We check if the group exists first so the script doesn't crash
$existingGroup = Get-AzADGroup -DisplayName $groupName -ErrorAction SilentlyContinue

if ($existingGroup) {
    Write-Host "Group $groupName already exists, skipping creation..." -ForegroundColor Yellow
} else {
    Write-Host "Creating Group: $groupName..." -ForegroundColor Cyan
    $group = New-AzADGroup -DisplayName $groupName -MailNickname "itadmins"
}

# 2. Define User Details
# FIX: Added 'labadmin@' before your domain name
$userUPN = "labadmin@jacobadedoyingriffithsgmail.onmicrosoft.com" 
$securePassword = ConvertTo-SecureString "AzureTesting123!" -AsPlainText -Force

# 3. Create the User
Write-Host "Creating User: $userUPN..." -ForegroundColor Cyan
$user = New-AzADUser -DisplayName "Lab Admin" `
                     -UserPrincipalName $userUPN `
                     -Password $securePassword `
                     -MailNickname "labadmin" `
                     -AccountEnabled $true

# 4. Add User to Group
Write-Host "Adding User to Group..." -ForegroundColor Cyan
Add-AzADGroupMember -TargetGroupDisplayName $groupName -MemberUserPrincipalName $userUPN

Write-Host "Done! Lab identities created successfully." -ForegroundColor Green

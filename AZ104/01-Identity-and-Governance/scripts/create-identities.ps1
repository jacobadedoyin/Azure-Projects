# 1. Create the Security Group
$groupName = "IT-Admins"
Write-Host "Creating Group: $groupName..."
$group = New-AzADGroup -DisplayName $groupName -MailNickname "itadmins"

# 2. Define User Details
# IMPORTANT: Change 'yourdomain.com' to your actual primary domain from the Azure Portal
$userUPN = "labadmin@yourdomain.com" 
$securePassword = ConvertTo-SecureString "AzureTesting123!" -AsPlainText -Force

# 3. Create the User
Write-Host "Creating User: $userUPN..."
$user = New-AzADUser -DisplayName "Lab Admin" `
                     -UserPrincipalName $userUPN `
                     -Password $securePassword `
                     -AccountEnabled $true

# 4. Add User to Group
Write-Host "Adding User to Group..."
Add-AzADGroupMember -TargetGroupDisplayName $groupName -MemberUserPrincipalName $userUPN

Write-Host "Done! Lab identities created successfully."

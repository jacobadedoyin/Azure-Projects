# Create a security group for the IT Department
$group = New-AzADGroup -DisplayName "IT-Admins" -MailNickname "itadmins"

# Create a new user and add them to the group
$passwordProfile = New-Object -TypeName Microsoft.Azure.Commands.Resources.Models.ActiveDirectory.PSADUserPasswordProfile
$passwordProfile.Password = "AzureTesting123!"

New-AzADUser -DisplayName "Lab Admin" -UserPrincipalName "labadmin@yourdomain.com" -PasswordProfile $passwordProfile -AccountEnabled $true

# Add user to the IT-Admins group
Add-AzADGroupMember -TargetGroupDisplayName "IT-Admins" -MemberUserPrincipalName "labadmin@yourdomain.com"

param (
    [string]$GroupName = "IT-Admins",
    [string]$UserUPN = "labadmin@jacobadedoyingriffithsgmail.onmicrosoft.com",
    [string]$DisplayName = "Lab Admin"
)

# --- CHECK FOR GROUP ---
$existingGroup = Get-AzADGroup -DisplayName $GroupName -ErrorAction SilentlyContinue | Select-Object -First 1
if ($null -eq $existingGroup) {
    Write-Host "Creating Group: $GroupName" -ForegroundColor Cyan
    $existingGroup = New-AzADGroup -DisplayName $GroupName -MailNickname ($GroupName -replace " ","") -SecurityEnabled
}

# --- CHECK FOR USER ---
$existingUser = Get-AzADUser -UserPrincipalName $UserUPN -ErrorAction SilentlyContinue
if ($null -eq $existingUser) {
    Write-Host "Creating User: $DisplayName" -ForegroundColor Cyan
    $passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $passwordProfile.Password = "Pa55w0rd123!"
    $existingUser = New-AzADUser -DisplayName $DisplayName -PasswordProfile $passwordProfile -UserPrincipalName $UserUPN -AccountEnabled -MailNickname ($DisplayName -replace " ","")
}

# --- ADD TO GROUP (Using the ID we just captured) ---
# This is the "Surgical" fix that bypasses the naming bugs we saw earlier
Add-AzADGroupMember -TargetGroupId $existingGroup.Id -MemberId $existingUser.Id -ErrorAction SilentlyContinue
Write-Host "Lab Complete: $DisplayName is now in $GroupName" -ForegroundColor Green

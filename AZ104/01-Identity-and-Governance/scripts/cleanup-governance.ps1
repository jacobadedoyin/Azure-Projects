$RG_Name = "AZ104-Lab"
$PolicyName = "Enforce-Small-VM"

# 1. Remove the Policy Assignment (Releases the 'Lock' on the Resource Group)
Remove-AzPolicyAssignment -Name $PolicyName -Scope (Get-AzResourceGroup -Name $RG_Name).ResourceId -Force

# 2. Remove the Policy Definition (Clean up the library)
Remove-AzPolicyDefinition -Name $PolicyName -Force

# 3. Cleanup Test Identities (Optional)
Remove-AzADGroup -DisplayName "IT-Admins" -Force

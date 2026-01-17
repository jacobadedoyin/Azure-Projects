# ==============================================================================
# Script Name: cleanup-governance.ps1
# Description: Removes all governance artifacts and identity objects created 
#              during the lab to prevent cost accrual and ensure a clean state.
# Author:      Jacob Adedoyin
# ==============================================================================

# --- Variables ---
$RG_Name     = "AZ104-Lab"
$PolicyName  = "Enforce-Cost-Optimised-VM-Sizes" # Updated to match your JSON policy
$AdGroupName = "IT-Admins"

# --- Execution ---

Write-Output "🧹 Starting Environment Cleanup..."

# 1. Remove Policy Assignment
# We must remove the assignment (the 'link') before we can delete the definition.
Write-Output "   [-] Removing Policy Assignment: $PolicyName..."
Get-AzPolicyAssignment -Name $PolicyName -Scope (Get-AzResourceGroup -Name $RG_Name).ResourceId -ErrorAction SilentlyContinue | Remove-AzPolicyAssignment -Force

# 2. Remove Policy Definition
# Cleans up the policy library definition to avoid clutter.
Write-Output "   [-] Removing Policy Definition..."
Get-AzPolicyDefinition -Name $PolicyName -ErrorAction SilentlyContinue | Remove-AzPolicyDefinition -Force

# 3. Cleanup Identity Objects
# Removes the Entra ID (Azure AD) group created for the lab.
Write-Output "   [-] Removing Identity Group: $AdGroupName..."
Get-AzADGroup -DisplayName $AdGroupName -ErrorAction SilentlyContinue | Remove-AzADGroup -Force

# 4. (Optional) Remove the Resource Group
# Uncomment the line below to completely nuke the lab resources (VMs, Disks, Network).
# Remove-AzResourceGroup -Name $RG_Name -Force -AsJob

Write-Output "✅ Cleanup Complete. Environment is clean."

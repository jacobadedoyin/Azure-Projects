<#
.SYNOPSIS
    Deploys Azure Policy for Cost Management (Project Phase 2).
.DESCRIPTION
    1. Reads the JSON definition from the 'policies' folder.
    2. Creates a Custom Policy Definition in Azure.
    3. Assigns the policy to the 'AZ104-Lab' Resource Group.
.NOTES
    Author: Jacob Adedoyin
    Project: AZ-104 Identity & Governance
#>

# Variables
$RG = "AZ104-Lab"
$PolicyName = "Enforce-Cost-Optimised-VM-Sizes"
$PolicyPath = "../policies/Enforce-Cost-Optimised-VM-Sizes.json"

# Check if JSON file exists
if (-not (Test-Path $PolicyPath)) {
    Write-Error "Policy JSON not found at $PolicyPath"
    exit
}

Write-Output "Creating Policy Definition: $PolicyName..."
$json = Get-Content -Raw $PolicyPath
$definition = New-AzPolicyDefinition -Name $PolicyName `
    -DisplayName "Enforce Cost-Optimised VM Sizes" `
    -Policy $json

Write-Output "Assigning Policy to Resource Group: $RG..."
# Get current subscription ID dynamically
$subId = (Get-AzContext).Subscription.Id

New-AzPolicyAssignment -Name "Assign-Cost-Policy" `
    -DisplayName "Enforce B-Series Only" `
    -Scope "/subscriptions/$subId/resourceGroups/$RG" `
    -PolicyDefinition $definition

Write-Output "Governance Applied Successfully."

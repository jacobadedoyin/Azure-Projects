# Apply a specific 'CanNotDelete' lock to the whole Resource Group
New-AzResourceLock -LockName "Critical-Guardrail" `
    -LockLevel CanNotDelete `
    -ResourceGroupName "RG-Governance-Lab" `
    -Force

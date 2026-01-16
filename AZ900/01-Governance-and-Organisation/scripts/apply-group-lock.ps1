param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [string]$LockName = "Critical-Guardrail",

    [ValidateSet("CanNotDelete", "ReadOnly")]
    [string]$LockLevel = "CanNotDelete"
)

$ErrorActionPreference = "Stop"

try {
    Write-Output "🔒 Applying '$LockLevel' lock to Resource Group: $ResourceGroupName..."

    New-AzResourceLock -LockName $LockName `
        -LockLevel $LockLevel `
        -ResourceGroupName $ResourceGroupName `
        -Force

    Write-Output "✅ Success: $ResourceGroupName is now protected."
}
catch {
    Write-Error "❌ Failed to apply lock: $_"
}

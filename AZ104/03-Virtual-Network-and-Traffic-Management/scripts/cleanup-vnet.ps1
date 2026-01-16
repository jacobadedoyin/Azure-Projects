# =========================================================================
# Project 03: Resource Cleanup Script
# =========================================================================
$RG = "AZ104-Lab"

Write-Host "🧹 Starting full network decommissioning..." -ForegroundColor Yellow

# 1. Remove Route Table Associations & NSG Associations (via Subnet update)
Write-Host "Resetting Subnet configurations..."
$vnet = Get-AzVirtualNetwork -Name "VNET-A-Prod" -ResourceGroupName $RG -ErrorAction SilentlyContinue
if ($vnet) {
    Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name "Web-Subnet" -AddressPrefix "10.0.1.0/24" -RouteTable $null -NetworkSecurityGroup $null | Set-AzVirtualNetwork | Out-Null
}

# 2. Remove Security & Routing Objects
Write-Host "Removing Security Groups and Route Tables..."
Remove-AzNetworkSecurityGroup -ResourceGroupName $RG -Name "NSG-Web-Tier" -Force -ErrorAction SilentlyContinue
Remove-AzNetworkSecurityGroup -ResourceGroupName $RG -Name "NSG-DB-Tier" -Force -ErrorAction SilentlyContinue
Remove-AzRouteTable -ResourceGroupName $RG -Name "RT-Web-to-NVA" -Force -ErrorAction SilentlyContinue

# 3. Remove VNets (This handles peering removal automatically)
Write-Host "Wiping Virtual Networks..."
Get-AzVirtualNetwork -ResourceGroupName $RG | Remove-AzVirtualNetwork -Force

Write-Host "✅ Environment Cleaned." -ForegroundColor Green

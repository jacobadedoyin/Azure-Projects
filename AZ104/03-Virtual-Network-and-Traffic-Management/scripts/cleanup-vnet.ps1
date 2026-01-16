# Example logic for safe resource decommissioning
$RG = "AZ104-Lab"

# 1. Remove VNET Peerings first to unlock VNET deletion
Get-AzVirtualNetwork -ResourceGroupName $RG | ForEach-Object {
    $vnet = $_
    $vnet.RemoteVirtualNetworkIds | ForEach-Object { Remove-AzVirtualNetworkPeering -VirtualNetworkName $vnet.Name -ResourceGroupName $RG -Name "*" -Force }
}

# 2. Remove Network Security Groups and Route Tables
Remove-AzNetworkSecurityGroup -ResourceGroupName $RG -Name "NSG-Web-Tier" -Force
Remove-AzRouteTable -ResourceGroupName $RG -Name "RT-Web-to-NVA" -Force

# 3. Final VNET Wipe
Get-AzVirtualNetwork -ResourceGroupName $RG | Remove-AzVirtualNetwork -Force

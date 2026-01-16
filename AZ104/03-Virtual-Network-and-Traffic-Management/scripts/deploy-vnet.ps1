# 1. Variables - Change these if needed
$RG = "AZ104-Lab"
$Loc = "northeurope" # Use a region where you have quota

# 2. Create VNET-A (Production Hub)
$vnetA = New-AzVirtualNetwork -Name "VNET-A-Prod" -ResourceGroupName $RG -Location $Loc -AddressPrefix "10.0.0.0/16"
Add-AzVirtualNetworkSubnetConfig -Name "Web-Subnet" -VirtualNetwork $vnetA -AddressPrefix "10.0.1.0/24"
Add-AzVirtualNetworkSubnetConfig -Name "DB-Subnet" -VirtualNetwork $vnetA -AddressPrefix "10.0.2.0/24"
$vnetA | Set-AzVirtualNetwork

# 3. Create VNET-B (Management Spoke)
$vnetB = New-AzVirtualNetwork -Name "VNET-B-Mgmt" -ResourceGroupName $RG -Location $Loc -AddressPrefix "10.1.0.0/16"
Add-AzVirtualNetworkSubnetConfig -Name "Mgmt-Subnet" -VirtualNetwork $vnetB -AddressPrefix "10.1.1.0/24"
$vnetB | Set-AzVirtualNetwork

# 4. Create Peering: VNET-A to VNET-B
Add-AzVirtualNetworkPeering -Name "Link-A-to-B" -VirtualNetwork $vnetA -RemoteVirtualNetworkId $vnetB.Id -AllowForwardedTraffic

# 5. Create Peering: VNET-B to VNET-A
Add-AzVirtualNetworkPeering -Name "Link-B-to-A" -VirtualNetwork $vnetB -RemoteVirtualNetworkId $vnetA.Id -AllowForwardedTraffic

Write-Host "Network Infrastructure Deployed Successfully!" -ForegroundColor Green

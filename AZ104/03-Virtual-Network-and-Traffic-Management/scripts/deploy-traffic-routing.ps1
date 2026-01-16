# =========================================================================
# Project 03: Phase 3 - Custom Traffic Routing (UDR)
# =========================================================================
$RG = "AZ104-Lab"
$Loc = "northeurope"

Write-Host "🚦 Initializing Phase 3: Traffic Routing..." -ForegroundColor Cyan
Write-Host "--------------------------------------------------------"

# 1. Create the Route Table
Write-Host "🛣️ Step 1: Creating Route Table [RT-Web-to-NVA]..." -NoNewline
$routeTable = New-AzRouteTable -Name "RT-Web-to-NVA" -ResourceGroupName $RG -Location $Loc
Write-Host " DONE" -ForegroundColor Green

# 2. Add the Forced Tunneling Route (0.0.0.0/0 to NVA)
Write-Host "🧱 Step 2: Defining Forced Tunneling Route..." -NoNewline
$routeTable | Add-AzRouteConfig -Name "ForcedTunnelToNVA" -AddressPrefix "0.0.0.0/0" `
    -NextHopType "VirtualAppliance" -NextHopIpAddress "10.0.1.100" | Set-AzRouteTable | Out-Null
Write-Host " DONE" -ForegroundColor Green

# 3. Associate Route Table with Web-Subnet
Write-Host "🔗 Step 3: Associating Route Table with Web-Subnet..." -NoNewline
$vnet = Get-AzVirtualNetwork -Name "VNET-A-Prod" -ResourceGroupName $RG
$null = Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name "Web-Subnet" `
    -AddressPrefix "10.0.1.0/24" -RouteTable $routeTable -NetworkSecurityGroup (Get-AzNetworkSecurityGroup -Name "NSG-Web-Tier" -ResourceGroupName $RG)
$null = Set-AzVirtualNetwork -VirtualNetwork $vnet
Write-Host " DONE" -ForegroundColor Green

Write-Host "--------------------------------------------------------"
Write-Host "⭐ Phase 3 Complete: Custom Traffic Routing is now active! ⭐" -ForegroundColor Cyan

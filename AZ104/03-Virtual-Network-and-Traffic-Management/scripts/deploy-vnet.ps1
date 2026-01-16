# =========================================================================
# Project 03: Virtual Networking Deployment (Hub-and-Spoke)
# =========================================================================
$RG = "AZ104-Lab"
$Loc = "northeurope"

Clear-Host
Write-Host "🚀 Initializing Network Deployment for Project 03..." -ForegroundColor Cyan
Write-Host "--------------------------------------------------------"

# 1. Create Hub VNET
Write-Host "📡 Step 1: Provisioning VNET-A (Production Hub)..." -NoNewline
$vnetA = New-AzVirtualNetwork -Name "VNET-A-Prod" -ResourceGroupName $RG -Location $Loc -AddressPrefix "10.0.0.0/16"
$vnetA | Add-AzVirtualNetworkSubnetConfig -Name "Web-Subnet" -AddressPrefix "10.0.1.0/24" -ServiceEndpoint "Microsoft.Storage"
$vnetA | Add-AzVirtualNetworkSubnetConfig -Name "DB-Subnet" -AddressPrefix "10.0.2.0/24"
$vnetA | Set-AzVirtualNetwork | Out-Null
Write-Host " DONE" -ForegroundColor Green

# 2. Create Spoke VNET
Write-Host "📡 Step 2: Provisioning VNET-B (Management Spoke)..." -NoNewline
$vnetB = New-AzVirtualNetwork -Name "VNET-B-Mgmt" -ResourceGroupName $RG -Location $Loc -AddressPrefix "10.1.0.0/16"
$vnetB | Add-AzVirtualNetworkSubnetConfig -Name "Mgmt-Subnet" -AddressPrefix "10.1.1.0/24"
$vnetB | Set-AzVirtualNetwork | Out-Null
Write-Host " DONE" -ForegroundColor Green

# 3. Create Network Security Group (NSG)
Write-Host "🛡️ Step 3: Hardening DB-Subnet with NSG Rules..." -NoNewline
$rule1 = New-AzNetworkSecurityRuleConfig -Name "AllowSQLFromWeb" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "10.0.1.0/24" -SourcePortRange * -DestinationAddressPrefix "10.0.2.0/24" -DestinationPortRange 1433
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $RG -Location $Loc -Name "NSG-DB-Tier" -SecurityRules $rule1
$vnetA = Get-AzVirtualNetwork -Name "VNET-A-Prod" -ResourceGroupName $RG
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnetA -Name "DB-Subnet" -AddressPrefix "10.0.2.0/24" -NetworkSecurityGroup $nsg | Set-AzVirtualNetwork | Out-Null
Write-Host " DONE" -ForegroundColor Green

# 4. Establish Peerings
Write-Host "🔗 Step 4: Connecting VNETs via Global Peering..." -NoNewline
Add-AzVirtualNetworkPeering -Name "Link-A-to-B" -VirtualNetwork $vnetA -RemoteVirtualNetworkId $vnetB.Id -AllowForwardedTraffic | Out-Null
Add-AzVirtualNetworkPeering -Name "Link-B-to-A" -VirtualNetwork $vnetB -RemoteVirtualNetworkId $vnetA.Id -AllowForwardedTraffic | Out-Null
Write-Host " DONE" -ForegroundColor Green

Write-Host "--------------------------------------------------------"
Write-Host "⭐ Deployment Complete! Your 'Highways' are now secure. ⭐" -ForegroundColor Cyan

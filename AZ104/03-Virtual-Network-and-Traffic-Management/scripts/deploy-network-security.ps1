$RG = "AZ104-Lab"
$Loc = "northeurope"

Write-Host "🛡️ Implementing Phase 2: Security & Micro-segmentation..." -ForegroundColor Cyan

# 1. Create the NSG for the Web Tier
$webNsg = New-AzNetworkSecurityGroup -ResourceGroupName $RG -Location $Loc -Name "NSG-Web-Tier"

# 2. Add Inbound Rules (HTTPS and SSH Management)
$webNsg | Add-AzNetworkSecurityRuleConfig -Name "Allow-HTTPS" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 443 | Out-Null
$webNsg | Add-AzNetworkSecurityRuleConfig -Name "Management-SSH" -Access Allow -Protocol Tcp -Direction Inbound -Priority 110 -SourceAddressPrefix "10.1.1.0/24" -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22 | Out-Null
$webNsg | Add-AzNetworkSecurityRuleConfig -Name "Deny-All-Inbound" -Access Deny -Protocol * -Direction Inbound -Priority 4000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange * | Out-Null

# 3. Save NSG and Associate with Web-Subnet
$webNsg | Set-AzNetworkSecurityGroup | Out-Null
$vnet = Get-AzVirtualNetwork -Name "VNET-A-Prod" -ResourceGroupName $RG
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name "Web-Subnet" -AddressPrefix "10.0.1.0/24" -NetworkSecurityGroup $webNsg -ServiceEndpoint "Microsoft.Storage" | Set-AzVirtualNetwork | Out-Null

Write-Host "✅ NSG Rules Applied and Service Endpoints Enabled!" -ForegroundColor Green

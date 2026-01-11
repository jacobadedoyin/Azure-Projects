targetScope = 'resourceGroup'

param location string = resourceGroup().location

// 1. Virtual Network Configuration

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'vnet-secure-storage'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'snet-private-link'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

// 2. Storage Account Configuration

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'stsecure${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Disabled'
    allowBlobPublicAccess: false
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}

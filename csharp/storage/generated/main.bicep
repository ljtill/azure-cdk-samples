targetScope = 'resourceGroup'

@description('')
param location string = resourceGroup().location


resource storageAccount_3KR8U9rje 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: toLower(take('sa${uniqueString(resourceGroup().id)}', 24))
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    networkAcls: {
      defaultAction: 'Deny'
    }
  }
}

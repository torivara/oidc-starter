param parLocation string = resourceGroup().location
param parStorageAccountName string

resource stg 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: parStorageAccountName
  location: parLocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

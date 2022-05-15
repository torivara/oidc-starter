//trigger
targetScope = 'subscription'

param parLocation string = 'westeurope'
param parResourceGroupName string = 'oidc-demo-rg'
@maxLength(10)
param parStorageAccountPrefix string = 'stg'

var varStorageAccountName = '${toLower(parStorageAccountPrefix)}${toLower(uniqueString(rg.id))}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: parResourceGroupName
  location: parLocation
}

module stg 'storage.bicep' = {
  name: 'storage-deployment'
  scope: resourceGroup(parResourceGroupName)
  params: {
    parStorageAccountName: varStorageAccountName
    parLocation: parLocation
  }
}

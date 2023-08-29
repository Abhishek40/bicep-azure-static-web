// @description('Storage Account Name')
// param storageAccountName string = 'staticweb${uniqueString(resourceGroup().id)}'

// param location string = 'eastus'

// @allowed([
//   'Premium_LRS'
//   'Premium_ZRS'
//   'Standard_GRS'
//   'Standard_GZRS'
//   'Standard_LRS'
//   'Standard_RAGRS'
//   'Standard_RAGZRS'
//   'Standard_ZRS'
// ])
// param sku_name string = 'Standard_LRS'

// resource staticWeb 'Microsoft.Storage/storageAccounts@2023-01-01' = {
//   name: storageAccountName
//   location: location
//   sku: {
//     name: sku_name
//   }
//   kind: 'StorageV2'
// }

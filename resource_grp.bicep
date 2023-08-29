// //Static Website Hosting
// @description('Resource group name')
// param rg_name string = 'rg_21'

// @description('Location')
// param location string = 'eastus'

// targetScope = 'subscription'
// //Resource Group creation
// resource rgNew 'Microsoft.Resources/resourceGroups@2022-09-01' = {
//   name: rg_name
//   location: location
// }

// module stgWeb 'static_web.bicep' = {
//   scope: rgNew
//   name: 'StaticWebModule'
//   params: {
//     location: location
//   }
// }

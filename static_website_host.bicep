// This template deploys an Azure Storage account, and then configures it to support static website hosting.
// Enabling static website hosting isn't possible directly in Bicep or an ARM template,
// so this sample uses a deployment script to enable the feature.
@description('The location into which resources should be deployed')
param location string = resourceGroup().location

@description('The storage account name to host static website')
param storageAccountName string = 'stor${uniqueString(resourceGroup().id)}'

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Premium_LRS'
])
@description('The storage account sku name')
param storageSku string = 'Standard_LRS'

@description('index to web app path')
param indexDocumentPath string = 'index.html'

@description('The contents of the web index document.')
param indexDocumentContents string = '<h1>Example static website</h1>'

@description('The path to the web error document')
param errorDocument404Path string = 'error.html'

@description('The content of the error document')
param errorDocument404Contents string = '<h1>Example 404 error page</h1>'

//This is the Storage Account Contributor role
resource contributorRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: '17d1049b-9a84-46fb-8f53-869881c3d3ab'
  //scope: subscription()
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'DeploymentScripts'
  location: location
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(resourceGroup().id, managedIdentity.id, contributorRoleDefinition.id)
  properties: {
    principalId: managedIdentity.properties.principalId
    roleDefinitionId: contributorRoleDefinition.id
    principalType: 'ServicePrincipal'
  }
}

resource deploymentScripts 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'deploymentScripts'
  location: location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}' : {}
    }
  }
  dependsOn: [
    roleAssignment
  ]
  properties: {
    azPowerShellVersion: '3.0'
    retentionInterval: 'PT4H'
    scriptContent: loadTextContent('./scripts/enable-static-website.ps1')
    environmentVariables: [
      {
        name: 'ResourceGroupName'
        value: resourceGroup().name
      }
      {
        name: 'StorageAccountName'
        value: storageAccount.name
      }
      {
        name: 'IndexDocumentPath'
        value: indexDocumentPath
      }
      {
        name: 'IndexDocumentContents'
        value: indexDocumentContents
      }
      {
        name: 'ErrorDocument404Path'
        value: errorDocument404Path
      }
      {
        name: 'ErrorDocument404Contents'
        value: errorDocument404Contents
      }
    ]
  }
}
output staticWebsiteUrl string = storageAccount.properties.primaryEndpoints.web

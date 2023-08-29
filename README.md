## bicep-azure-static-web
Static website hosting on Azure using Bicep

## Deployment process
    az deployment group create --resource-group resoureGroup21 --template-file static_website_host.bicep
    az deployment group delete --resource-group resoureGroup21 --template-file static_website_host.bicep
    az deployment operation group list --resource-group resoureGroup21 --name staticDeploy21
```t
    az bicep version
    az bicep upgrade
```
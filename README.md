## bicep-azure-static-web
Static website hosting on Azure using Bicep

## Deployment process
    az deployment sub create --template-file static_website.bicep --location eastus
    az deployment sub delete --template-file static_website.bicep --location eastus
    az deployment group create --resource-group resoureGroup21 --template-file static_website_host.bicep --location eastus
    az deployment operation group list --resource-group resoureGroup21 --name ExampleDeployment
```t
    az bicep version
    az bicep upgrade
```
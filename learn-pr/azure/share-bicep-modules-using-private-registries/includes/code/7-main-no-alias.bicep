@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The name of the App Service app.')
param appServiceAppName string = 'dog-${uniqueString(resourceGroup().id)}'

@description('The name of the App Service plan SKU.')
param appServicePlanSkuName string = 'F1'

var appServicePlanName = 'toy-dog-plan'

module website 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/website:v1' = {
  name: 'toy-dog-website'
  params: {
    appServiceAppName: appServiceAppName
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServicePlanSkuName
    location: location
  }
}

module cdn 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/cdn:v1' = {
  name: 'toy-dog-cdn'
  params: {
    httpsOnly: true
    originHostName: website.outputs.appServiceAppHostName
  }
}

targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

param resourceGroupName string = ''

param chatFrontendAppName string = 'chatfrontendapp'

param logAnalyticsName string = ''
param applicationInsightsName string = ''

@description('Location for the Static Web App')
@allowed(['westus2', 'centralus', 'eastus2', 'westeurope', 'eastasia', 'eastasiastage'])
@metadata({
  azd: {
    type: 'location'
  }
})
param chatFrontendAppLocation string

@description('Use Application Insights for monitoring and performance tracing')
param useApplicationInsights bool = false

// Allow to override the default backend
param backendUri string = ''

param isLib string = ''

// Only needed for CD due to internal policies restrictions
param aliasTag string = ''

var abbrs = loadJsonContent('abbreviations.json')
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))
var tags = union({ 'azd-env-name': environmentName }, empty(aliasTag) ? {} : { alias: aliasTag })

// Organize resources in a resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: !empty(resourceGroupName) ? resourceGroupName : '${abbrs.resourcesResourceGroups}${environmentName}'
  location: location
  tags: tags
}

// The application frontend
module chatFrontendApp './core/host/staticwebapp.bicep' = {
  name: 'chatfrontendapp'
  scope: resourceGroup
  params: {
    name: !empty(chatFrontendAppName) ? chatFrontendAppName : '${abbrs.webStaticSites}web-${resourceToken}'
    location: chatFrontendAppLocation
    tags: union(tags, { 'azd-service-name': chatFrontendAppName })
  }
}

// Monitor application with Azure Monitor
module monitoring './core/monitor/monitoring.bicep' = {
  name: 'monitoring'
  scope: resourceGroup
  params: {
    location: location
    tags: tags
    logAnalyticsName: !empty(logAnalyticsName) ? logAnalyticsName : '${abbrs.operationalInsightsWorkspaces}${resourceToken}'
    applicationInsightsName: useApplicationInsights ? (!empty(applicationInsightsName) ? applicationInsightsName : '${abbrs.insightsComponents}${resourceToken}') : ''
  }
}

output AZURE_LOCATION string = location
output AZURE_TENANT_ID string = tenant().tenantId
output AZURE_RESOURCE_GROUP string = resourceGroup.name

output FRONTEND_URI string = chatFrontendApp.outputs.uri

output BACKEND_URI string = !empty(backendUri) ? backendUri : ''

output IS_LIB string = isLib

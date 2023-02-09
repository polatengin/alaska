targetScope = 'subscription'

param name string = 'sample-rg'
param location string = deployment().location

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: name
  location: location
}

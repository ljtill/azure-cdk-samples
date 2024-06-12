targetScope = 'resourceGroup'

@description('')
param location string = resourceGroup().location

@description('')
param adminLogin string

@secure()
@description('')
param adminPassword string


resource cosmosDBAccount_lAzkDqkAw 'Microsoft.DocumentDB/databaseAccounts@2023-04-15' = {
  name: toLower(take('cosmos${uniqueString(resourceGroup().id)}', 24))
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: 'westus'
      }
    ]
  }
}

resource cosmosDBSqlDatabase_GMVbespWJ 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2023-04-15' = {
  parent: cosmosDBAccount_lAzkDqkAw
  name: 'sample'
  location: location
  properties: {
    resource: {
      id: 'sample'
    }
  }
}

resource sqlServer_yY54WrWpQ 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: toLower(take('sql${uniqueString(resourceGroup().id)}', 24))
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    version: '12.0'
    publicNetworkAccess: 'Enabled'
  }
}

resource sqlDatabase_Waxc0KC32 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  parent: sqlServer_yY54WrWpQ
  name: 'sample'
  location: location
  properties: {
  }
}

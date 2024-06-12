targetScope = 'resourceGroup'

@description('')
param location string = resourceGroup().location


resource eventHubsNamespace_NMvIPvBBM 'Microsoft.EventHub/namespaces@2021-11-01' = {
  name: toLower(take('eh${uniqueString(resourceGroup().id)}', 24))
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
  }
}

resource eventHub_DvNstsR37 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  parent: eventHubsNamespace_NMvIPvBBM
  name: 'hub'
  location: location
  properties: {
  }
}

resource eventHubsConsumerGroup_3vXVh7pBW 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2021-11-01' = {
  parent: eventHub_DvNstsR37
  name: 'cg'
  location: location
  properties: {
  }
}

resource roleAssignment_DtmVsoSLa 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: eventHubsNamespace_NMvIPvBBM
  name: guid(eventHubsNamespace_NMvIPvBBM.id, '00000000-0000-0000-0000-000000000000', subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f526a384-b230-433a-b45c-95f59c4a2dec'))
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f526a384-b230-433a-b45c-95f59c4a2dec')
    principalId: '00000000-0000-0000-0000-000000000000'
    principalType: 'ServicePrincipal'
  }
}

resource serviceBusNamespace_ZWLWzEXEq 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: toLower(take('sb${uniqueString(resourceGroup().id)}', 24))
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
  }
}

resource serviceBusQueue_rtLJIsxUz 'Microsoft.ServiceBus/namespaces/queues@2021-11-01' = {
  parent: serviceBusNamespace_ZWLWzEXEq
  name: 'queue'
  location: location
  properties: {
  }
}

resource serviceBusTopic_m8h7YH1KX 'Microsoft.ServiceBus/namespaces/topics@2021-11-01' = {
  parent: serviceBusNamespace_ZWLWzEXEq
  name: 'topic'
  location: location
  properties: {
  }
}

resource roleAssignment_ocuHD619b 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: serviceBusNamespace_ZWLWzEXEq
  name: guid(serviceBusNamespace_ZWLWzEXEq.id, '00000000-0000-0000-0000-000000000000', subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '090c5cfd-751d-490a-894a-3ce6f1109419'))
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '090c5cfd-751d-490a-894a-3ce6f1109419')
    principalId: '00000000-0000-0000-0000-000000000000'
    principalType: 'ServicePrincipal'
  }
}

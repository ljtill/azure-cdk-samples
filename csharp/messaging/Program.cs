using Azure.Provisioning;
using Azure.Provisioning.EventHubs;
using Azure.Provisioning.ServiceBus;

// Create new infrastructure
var infra = new SampleInfrastructure();

// Add new Event Hub
var account = new EventHubsNamespace(infra);
var hub = new EventHub(infra, parent: account);

// Add new Consumer Group
_ = new EventHubsConsumerGroup(infra, parent: hub);

// Assign Data Role Permissions
account.AssignRole(RoleDefinition.EventHubsDataOwner, Guid.Empty);

// Add new Service Bus
var bus = new ServiceBusNamespace(infra);

// Add new Queue
_ = new ServiceBusQueue(infra, parent: bus);

// Add new Topic
_ = new ServiceBusTopic(infra, parent: bus);

bus.AssignRole(RoleDefinition.ServiceBusDataOwner, Guid.Empty);

// Build the infrastructure into Bicep files
infra.Build(outputPath: "generated");

public class SampleInfrastructure : Infrastructure
{
    public SampleInfrastructure() : base(envName: "Sample", tenantId: Guid.Empty, subscriptionId: Guid.Empty, configuration: new Configuration { UseInteractiveMode = true })
    { }
}

using Azure.Provisioning;
using Azure.Provisioning.Storage;
using Azure.ResourceManager.Storage.Models;

// Create new infrastructure
var infra = new SampleInfrastructure();

// Add the Storage Account resource
infra.AddStorageAccount(kind: StorageKind.StorageV2, sku: StorageSkuName.StandardLrs);

// Build the infrastructure into Bicep files
infra.Build(outputPath: "generated");

public class SampleInfrastructure : Infrastructure
{
    public SampleInfrastructure() : base(envName: "Sample", tenantId: Guid.Empty, subscriptionId: Guid.Empty, configuration: new Configuration { UseInteractiveMode = true })
    { }
}

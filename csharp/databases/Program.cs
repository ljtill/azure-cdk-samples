using Azure.Provisioning;
using Azure.Provisioning.CosmosDB;
using Azure.Provisioning.Sql;
using Azure.ResourceManager.CosmosDB.Models;

// Create new infrastructure
var infra = new SampleInfrastructure();

// Create CosmosDB
var account = new CosmosDBAccount(infra, name: "cosmos", kind: CosmosDBAccountKind.GlobalDocumentDB);

// Add Database
_ = new CosmosDBSqlDatabase(infra, parent: account, name: "sample");

// Create SQL
var sql = new SqlServer(infra, name: "sql", administratorLogin: new Parameter("adminLogin"), administratorPassword: new Parameter("adminPassword", isSecure: true));

// Add Database
_ = new SqlDatabase(infra, parent: sql, name: "sample");

// Generate Bicep output files
infra.Build(outputPath: "generated");

public class SampleInfrastructure : Infrastructure
{
    public SampleInfrastructure() : base(envName: "Sample", tenantId: Guid.Empty, subscriptionId: Guid.Empty, configuration: new Configuration { UseInteractiveMode = true })
    { }
}

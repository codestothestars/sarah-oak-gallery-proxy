# Sarah Oak Gallery Proxy
The web proxy for Sarah Oak's gallery server.

Enables communication with the API at [sarahoak.piwigo.com](https://sarahoak.piwigo.com) from the front-end of [sarahoak.com](http://sarahoak.com).

This proxy is implemented as an [Azure Function](https://azure.microsoft.com/en-us/services/functions).

## Development
### Dependencies
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) (needed for local development environment setup)
* [Node.js](https://nodejs.org) 10.15 ([nvm](https://github.com/creationix/nvm) is recommended)

### Install
Once you've installed the above dependencies and cloned this repository, install NPM dependencies.

```shell
npm install
```

### Environment Setup
Even for local development, Azure Functions expect access to a storage account. Run the following shell commands to create a resource group and storage account...
```shell
resourceGroup=sarah-oak-gallery-proxy

az group create --name $resourceGroup

az storage account create \
    --https-only \
    --kind StorageV2 \
    --name $storageAccountName \
    --resource-group $resourceGroup \
    --sku Standard_LRS
```

...where `$storageAccountName` is a unique name for your storage account.

Retrieve the connection string for the storage account...

```shell
az storage account show-connection-string \
    --name $storageAccountName \
    --output tsv \
    --query connectionString \
    --resource-group $resourceGroup
```

...then add it to your local settings.

```shell
npx func settings add AzureWebJobsStorage "$connectionString"
```

#!/bin/bash

# Creates the Azure resources for the Azure Functions application.
# Expects values for the following variables to be available:
# $functionApp    - The name of the Azure Functions application to create. Must be globally unique on Azure.
# $storageAccount - The name of the Azure storage account in which resources will be stored. Must be globally unique on Azure.

resourceGroup=sarah-oak-gallery-proxy

az resource create \
    --is-full-object \
    --name service-plan \
    --properties '{
        "location": "eastus",
        "sku": {
            "name": "Y1",
            "tier": "dynamic"
        }
    }' \
    --resource-group $resourceGroup \
    --resource-type Microsoft.Web/serverfarms

az functionapp create \
    --consumption-plan-location eastus \
    --name $functionApp \
    --resource-group $resourceGroup \
    --runtime node \
    --storage-account $storageAccount

az functionapp cors add \
    --allowed-origins http://localhost:4200 http://sarahoak.com \
    --name $functionApp \
    --resource-group $resourceGroup

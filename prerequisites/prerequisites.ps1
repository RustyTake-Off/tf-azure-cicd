# Script for creating prerequisites.
$resource_group = "rgpr09pro"
$location = "westeurope"
$storage_account = "strapr09pro"
$container = "contpr09pro"

# Resource group
az group create --name $resource_group --location $location

# Storage account
az storage account create --name $storage_account --resource-group $resource_group --location $location --access-tier Cool --sku Standard_LRS --min-tls-version TLS1_2

# Query storage account access key
$storage_access_key = $(az storage account keys list --account-name $storage_account --resource-group $resource_group --query [0].value -o tsv)

# Storage container
az storage container create --name $container --account-name $storage_account --account-key $storage_access_key --fail-on-exist

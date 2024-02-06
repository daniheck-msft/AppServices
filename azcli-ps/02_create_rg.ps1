$rg="deleteme001"
$region = "eastus"
$uniqueId = (Get-Random -Minimum 1000 -Maximum 9999)    
###############################
# create
###############################
az group create --location $region --resource-group $rg

###############################
# List resources in RG (shourld be empty)
###############################
az resource list --resource-group $rg --output table

# Documentation: https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal
# Pricing: https://azure.microsoft.com/en-us/pricing/details/resource-manager/
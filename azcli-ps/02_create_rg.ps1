$rg="deleteme001"
$region = "eastus"

###############################
# create
###############################
az group create --location $region --resource-group $rg

###############################
# List resources in RG
###############################
az resource list --resource-group $rg --output table

###############################
# delete
###############################
az group delete --resource-group $rg --yes

# Documentation: https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal
# Pricing: https://azure.microsoft.com/en-us/pricing/details/resource-manager/
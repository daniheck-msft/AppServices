$rg="AppServices001"
$location="eastus"
$appServicePlan="CustomContainerServicePlan"
$containerApp="CustomContainerWebApp"

az appservice plan create --name $appServicePlan --resource-group $rg --sku S1 --is-linux

git clone https://github.com/Azure-Samples/multicontainerwordpress
cd multicontainerwordpress

az webapp create --resource-group $rg --plan $appServicePlan --name $containerApp `
--multicontainer-config-type compose --multicontainer-config-file docker-compose-wordpress.yml


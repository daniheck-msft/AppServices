# this will deploy a custom container webapp 

$webapp = $rg+"CusCon"+$uniqueId
$appServicePlanCusCon = $appServicePlan+"CusCon"
echo $appServicePlanCusCon
echo $webapp

# create an App Service plan based on linux
az appservice plan create --name $appServicePlanCusCon --resource-group $rg --sku S1 --is-linux

# git clone https://github.com/Azure-Samples/multicontainerwordpress
cd multicontainerwordpress

az webapp create --resource-group $rg --plan $appServicePlanCusCon --name $webapp `
--multicontainer-config-type compose --multicontainer-config-file docker-compose-wordpress.yml

# wait a minute or two for the container to ramp up

$url = az webapp show --name $webapp --resource-group $rg --query "defaultHostName" --output tsv
echo $url
#show webapp in chrome
start chrome $url
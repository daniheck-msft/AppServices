# $rg="bc-AppServices"
# $region = "eastus"
# $webappname = "myPlayWebApp"
# $appplanname = "playAppPlan"
$webappname = $rg+"WebApp"
$appplanname = $rg+"AppPlan"

#########################################
# Sample Get App 
#########################################
git clone https://github.com/Azure-Samples/html-docs-hello-world.git
cd html-docs-hello-world

#########################################
# Create RG 
#########################################
az group create --location $region --resource-group $rg

#########################################
# Deploy Web App including AppPlan
#########################################
az webapp up --location $region --name $webappname --resource-group $rg --plan $appplanname --html --sku F1 -b
#show url of the webapp
$url = az webapp show --name $webappname --resource-group $rg --query "defaultHostName" --output tsv
#show webapp in chrome
start chrome $url

#########################################
# Deploy ReactApp1 
#########################################

# create a new ReactApp in Visual Studio
# create a local and remote git repository called ReactApp1
# will be pushed automatically 

# create test webapp in azure
$ReactApp1=$rg+"ReactApp"
# $repourl="https://github.com/daniheck-msft/ReactApp1.git"
az webapp create --name $ReactApp1 --resource-group $rg --plan $appplanname

#az webapp deployment source config --name $ReactApp1 --resource-group $rg --repo-url $repourl --branch master --manual-integration
start chrome "https://portal.azure.com" #manually configure deployment from github in Section Deployment Center 
# in the azure portal go to web app and select Deployment Center
# select github and configure the repository and branch
# save and wait for the deployment to finish

# sync from configured github repo
az webapp deployment source sync --name $ReactApp1 --resource-group $rg

# az ad sp create-for-rbac --name ReactApp1 --role contributor --scopes /subscriptions/4e23649f-a275-494e-923f-4f56241e352e/resourceGroups/bc-AppServices --json-auth --only-show-errors
# az ad sp create-for-rbac --name ReactApp1 --role contributor --scopes /subscriptions/4e23649f-a275-494e-923f-4f56241e352e/resourceGroups/bc-AppServices --json-auth

$url = az webapp show --name $ReactApp1 --resource-group $rg --query "defaultHostName" --output tsv
echo $url
#show webapp in chrome
start chrome $url

#update webapp
az webapp up --location $region --name $webappname --resource-group $rg --plan $appplanname --html --sku F1 -b

#########################################
# Delete Web App including AppPlan
#########################################
az webapp delete --name $webappname --resource-group $rg 
az appservice plan delete --resource-group $rg --name $appplanname --yes

###############################
# List resources in RG
###############################
az resource list --resource-group $rg --output table

# Documentation: https://docs.microsoft.com/en-us/azure/app-service/
# Pricing: https://azure.microsoft.com/en-us/pricing/details/app-service/


# $rg="bc-AppServices002"
# $region = "eastus"
$webapp = "WebAppFromGitHub002"
$appServicePlan = $appplanname 
$tag="deploy-github.sh"
$gitrepo="https://github.com/Azure-Samples/php-docs-hello-world" # Replace the following URL with your own public GitHub repo URL if you have one

# Create an App Service plan in `FREE` tier.
# az appservice plan create --name $appServicePlan --resource-group $resourceGroup --sku FREE

# Create a web app.
echo $appServicePlan
az webapp create --name $webapp --resource-group $rg --plan $appServicePlan

# Deploy code from a public GitHub repository. 
az webapp deployment source config --name $webapp --resource-group $rg --repo-url $gitrepo --branch master --manual-integration

$url = az webapp show --name $webapp --resource-group $rg --query "defaultHostName" --output tsv
echo $url
#show webapp in chrome
start chrome $url


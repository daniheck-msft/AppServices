#########################################
# Define names for WebApp and AppPlan 
#########################################
$webappname = $rg+"WebApp"+$uniqueId
$appplanname = $rg+"AppPlan"+$uniqueId

#########################################
# clone plain sampe app from github
#########################################
git clone https://github.com/Azure-Samples/html-docs-hello-world.git
cd html-docs-hello-world

#########################################
# Deploy Web App including AppPlan
#########################################
az webapp up --location $region --name $webappname --resource-group $rg --plan $appplanname --html --sku P1v3 -b
#show url of the webapp
$url = az webapp show --name $webappname --resource-group $rg --query "defaultHostName" --output tsv
#show webapp in chrome
start chrome $url



#########################################
# Deploy ReactApp1 
#########################################

# create a new ReactApp in Visual Studio
# in ..\reactapp1.client\src\App.tsx add/change the following line 
# return (
#     <div>
#         <h1 id="tabelLabel">AppServices Test Weather forecast</h1>
#         <h1 id="tabelLabel">updated 06.02.2024 - 10:11</h1>

# create a local and remote git repository called ReactApp1
# go to menu Git->Push to Git Service and push the code to the remote repository
# go to Git Changes and push the changes

# create test webapp in azure
$ReactApp1=$rg+"ReactApp"+$uniqueId
az webapp create --name $ReactApp1 --resource-group $rg --plan $appplanname

start chrome "https://portal.azure.com" 
# in the Azure Portal, go to the web app and select Deployment Center -> Settings
# define the runtime stack to .NET -> .NET8 (LTS)
# switch SCM Basic Auth Publishing to On
# save and after (X in the upper right) close the runtime stack window 
# sign in / authorize github and select the repository and branch 
# make sure to use basic authentication to deploy to Azure and save
# go to github and check the action

$url = az webapp show --name $ReactApp1 --resource-group $rg --query "defaultHostName" --output tsv
echo $url
#show webapp in chrome
start chrome $url

# Documentation: https://docs.microsoft.com/en-us/azure/app-service/
# Pricing: https://azure.microsoft.com/en-us/pricing/details/app-service/


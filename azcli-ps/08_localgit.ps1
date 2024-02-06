$webapp = $rg+"WAFLG"+$uniqueId

# Clone the sample repository and change to the repository root.
# this was already done in this demo repo for you
# git clone https://github.com/Azure-Samples/dotnet-core-api
cd ..\dotnet-core-api
# select the main branch
# git branch -m main

# to run the application locally ... 
# it's recommended to open the solution in VS ... you might get notified that the .NET version isn't installed on your machine
# if that is the case ... install it then then open the project 

# run the app
dotnet restore
dotnet run
# check the app (port is shown in the console)
# CTRL-C

# https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api#deploy-app-to-azure
# request user to input username and password in powershell and store them in repective variables
$username = Read-Host -Prompt "Enter username"
$password = Read-Host -Prompt "Enter password" -AsSecureString
$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
# set the deployment user
az webapp deployment user set --user-name $username --password $password

echo $appServicePlan
echo $webapp

# create a web app to deploy from local git
az webapp create --name $webapp --resource-group $rg --plan $appServicePlan --deployment-local-git

# set the deployment branch to main
az webapp config appsettings set --name $webapp --resource-group $rg --settings DEPLOYMENT_BRANCH='main'

# Get the deploymentLocalGitUrl
$localgiturl = az webapp deployment source config-local-git --name $webapp --resource-group $rg --query url --output tsv
echo $localgiturl

# add remote to local repository and push local commits to Azure
git remote remove azure # remove the remote if it already exists
git remote add azure $localgiturl

# Set basic authentication publishing credentials to true
az resource update --resource-group $rg --name scm --namespace Microsoft.Web `
    --resource-type basicPublishingCredentialsPolicies --parent sites/$webapp --set properties.allow=true
# you can also enable basic authentication in the web app over the portal 
# in configuration->general settings->basic auth publishing credentials

# commit and push the changes
git push azure main

echo $webapp
start chrome "$webapp.azurewebsites.net/swagger"








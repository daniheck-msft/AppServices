$rg="AppServices001"
$region = "eastus"
$webapp = "localgitwebapp0836"
$appServicePlan = "WANetCoreRazor00120240116183905Plan"
# https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api

# Clone the sample repository and change to the repository root.
git clone https://github.com/Azure-Samples/dotnet-core-api
cd dotnet-core-api
git branch -m main

# Run the application
# vorher mit Visual Studio öffnen ... das sagt dann ".NET version nicht installiert" ... die installieren und dann das Projekt öffnen
dotnet restore
dotnet run

# https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-rest-api#deploy-app-to-azure
# request user to input username and password in powershell and store them in repective variables
# $username = "someusername"
# $password = "s0m3p@ssw0rd"
$username = Read-Host -Prompt "Enter username"
$password = Read-Host -Prompt "Enter password" -AsSecureString
$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
az webapp deployment user set --user-name $username --password $password

# # create a resource group
# az group create --name $rg --location $region

# # Create an App Service plan in `S1` tier.
# az appservice plan create --name $appServicePlan --resource-group $rg --sku S1

# create a web app to deploy from local git
az webapp create --name $webapp --resource-group $rg --plan $appServicePlan --deployment-local-git

# set the deployment branch to main
az webapp config appsettings set --name $webapp --resource-group $rg --settings DEPLOYMENT_BRANCH='main'

$localgiturl = 'https://daniheckazure@localgitwebapp0836.scm.azurewebsites.net/localgitwebapp0836.git'
echo $localgiturl

# add remote to local repository and push local commits to Azure
git remote add azure $localgiturl
# had to enable basic authentication in the web app over the portal in configuration->general settings->basic auth publishing credentials
# otherwise you get fatal: Authentication failed for 'bla'
az resource update --resource-group $rg --name scm --namespace Microsoft.Web `
    --resource-type basicPublishingCredentialsPolicies --parent sites/$webapp --set properties.allow=true

git push azure main

echo $webapp
start chrome "$webapp.azurewebsites.net/swagger"








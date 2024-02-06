# create a new ASP.NET Core Web (MVC) App in Visual Studio
# choose .NET 8.0 LTS
# if you don't have an Azure DevOps org yet, create one
# https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/create-organization?view=azure-devops
# make sure you have 1 free parrallel job ... if you don't have one, request the free tier
# https://forms.office.com/pages/responsepage.aspx?id=v4j5cvGGr0GRqy180BHbR5zsR558741CrNi6q8iTpANURUhKMVA3WE4wMFhHRExTVlpET1BEMlZSTCQlQCN0PWcu
# can take up to 2-3 business days to get approved
# create a new project in Azure DevOps
# https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops
# in VS open Git -> Create Git Repository -> Choose Azure DevOps -> select the project -> define a new repository name -> Create

$webapp = $rg+"WAFromADO"+$uniqueId
echo $appServicePlan
echo $webapp
az webapp create --name $webapp --resource-group $rg --plan $appServicePlan

# in Azure DevOps, go to the Repo and click setup build. choose to build .NET Core
# show the assistant
# go to the end of the file and add a task to deploy the webapp to Azure App Service deploy 
# if required click "Authorize"
# select Subscription, AppType "Web App in Windows", App Service Name 
# replace the "package" with "$(Pipeline.Workspace)\**\*.zip"
# click and then click "Save and run"
# select the job to view the details of the run
# click "view" and "permit" (yellow alert) if necessary
# wait till the job is finished

$url = az webapp show --name $webapp --resource-group $rg --query "defaultHostName" --output tsv
echo $url
#show webapp in chrome
start chrome $url

# in VS edit Views/Home/Index.cshtml for example with an additional line like  
#     <h1 class="display-4">updated on 06.02.2024 22:50</h1>
# in VS go to Git Changes and commit and push the changes
# check back in the Azure DevOps pipeline and see the changes in the build and deployment
# check the webapp in the browser and see the changes


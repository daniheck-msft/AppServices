
# https://learn.microsoft.com/en-us/azure/app-service/deploy-azure-pipelines?tabs=yaml
# https://github.com/MicrosoftDocs/azure-devops-docs/issues/8360


# ASP.NET
# Build and test ASP.NET projects.
# Add steps that publish symbols, save build artifacts, deploy, and more:
# https://docs.microsoft.com/azure/devops/pipelines/apps/aspnet/build-aspnet-4

# fixed Azure DevOps pipeline as the on autogenerated be Visual Studio is broken per default, 
# because the folder structure in the generated YAML is incorrect

trigger:
- master

pool:
  vmImage: 'windows-latest'

variables:
  solution: '**/*.sln'
  buildPlatform: 'Any CPU'
  buildConfiguration: 'Release'

steps:
- task: NuGetToolInstaller@1

- task: NuGetCommand@2
  inputs:
    restoreSolution: '$(solution)'

- task: VSBuild@1
  inputs:
    solution: '$(solution)'
    msbuildArgs: '/p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:SkipInvalidConfigurations=true /p:PackageLocation="$(build.artifactStagingDirectory)"'
    platform: '$(buildPlatform)'
    configuration: '$(buildConfiguration)'

- task: VSTest@2
  inputs:
    platform: '$(buildPlatform)'
    configuration: '$(buildConfiguration)'

# some scripts I used to debug the dirs used by the pipeline    
- script: echo '$(Pipeline.Workspace)' 
- script: dir $(Pipeline.Workspace) /s 
#- script: dir
#  workingDirectory: $(Pipeline.Workspace)
#- script: dir /s
#  workingDirectory: $(Pipeline.Workspace)
- script: dir $(Pipeline.Workspace)\a\ /s 

- task: AzureRmWebAppDeployment@4
  inputs:
    ConnectionType: 'AzureRM'
    azureSubscription: '###SubscriptionNAME### (###subGUID###)'
    appType: 'webApp'
    WebAppName: 'YAASPdotNETHelloWorldApp001'
###############################
# the following line was added to fix the deployment
###############################
    packageForLinux: '$(Pipeline.Workspace)\**\*.zip'
###############################
# exchanging what comes from the assistant with the above line did the trick
###############################
    
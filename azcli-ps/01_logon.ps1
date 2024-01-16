#Loging in to Azure
az login

$subscriptions = az account list --query '[].{Name:name, ID:id}' | ConvertFrom-Json
$subscription = $subscriptions | Out-GridView -Title "Select Subscription" -PassThru
az account set --subscription $subscription.ID

az group list --output table

#########################################

# Log in to Azure using a pop-up window for interactive authentication
Connect-AzAccount

# Select the subscription you want to use
$subscription = (Get-AzSubscription | Out-GridView -Title "Select a Subscription" -PassThru)
Set-AzContext -Subscription $subscription.Id

# Confirm the selected subscription
Write-Host "Using Azure subscription: $($subscription.Name)" -ForegroundColor Green



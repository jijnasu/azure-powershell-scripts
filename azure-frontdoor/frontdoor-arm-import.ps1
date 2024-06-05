Connect-AzAccount
#Set-AzContext -SubscriptionId "e36acc20-6d9e-4d42-ac42-c9661094f1c0"
Set-AzContext -SubscriptionId "dbc19710-5d67-4edb-81de-14e5d1454dd1"
$resourceGroupName = "myRGFD-33333333"
$deploymentName = "FrontDoorDeployment-3333333"
$templateFilePath = "C:\Users\jijnasu\Documents\kjworkspace\FD-ARM.json"

New-AzResourceGroup -Name $resourceGroupName -Location centralus
# Define deployment parameters
$deploymentParameters = @{
    "resourceGroupName" = $resourceGroupName
    "deploymentName" = $deploymentName
    "templateFile" = $templateFilePath
}

# Deploy the ARM template
New-AzResourceGroupDeployment @deploymentParameters
Write-Host "ARM template imported successfully to $resourceGroupName"
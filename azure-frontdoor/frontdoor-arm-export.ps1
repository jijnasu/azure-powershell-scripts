Connect-AzAccount
#Set-AzContext -SubscriptionId "e36acc20-6d9e-4d42-ac42-c9661094f1c0"
Set-AzContext -SubscriptionId "e8f6937f-23f9-450d-b4d4-095e52ea4069"
$resourceGroupName = "jijpwc-sourceRG"
$resourceName = "contosoAFD"
$localFilePath = "C:\Users\jijnasu\Documents\kjworkspace\sourceFD-ARM.json"
$resource = Get-AzResource -ResourceGroupName $resourceGroupName -ResourceName $resourceName

Export-AzResourceGroup -ResourceGroupName $resourceGroupName -Resource $resource.ResourceId -Path $localFilePath -IncludeParameterDefaultValue
Write-Host "ARM template exported successfully to $localFilePath."

Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$RGNameTemplate = "RG-ARM-Demo-Template"
$StgAcctName = "ARMDemotemplateStorage".ToLower()
$templateContainerName = "armtemplates"
$loc = "China North"
$storageEndpointSuffix = "core.chinacloudapi.cn"
#prepare resource group
New-AzureRmResourceGroup -Name $RGNameTemplate -Location $loc -Force |Out-Null
#prepare storage account and container
New-AzureRmStorageAccount -ResourceGroupName $RGNameTemplate -Name $StgAcctName -Type Standard_LRS -Location $loc|Out-Null
$key = (Get-AzureRmStorageAccountKey -ResourceGroupName $RGNameTemplate -Name $StgAcctName).Key1
$ctx = New-AzureStorageContext -StorageAccountName $StgAcctName -StorageAccountKey $key
$cnt = (Get-AzureStorageContainer -Name $templateContainerName -Context $ctx -ErrorAction SilentlyContinue)
if($cnt -eq $null)
{
    New-AzureStorageContainer -Name $templateContainerName -Permission Blob -Context $ctx |Out-Null
}
#Azure\Remove-AzureStorageBlob -Blob "JumpboxDscConfiguration.ps1.zip" -Container $templateContainerName -Context $ctx
Set-AzureStorageBlobContent -Container $templateContainerName -File applicationsystem.json -Context $ctx -Force|Out-Null
Set-AzureStorageBlobContent -Container $templateContainerName -File applicationsystem.chinanorth.parameters.json -Context $ctx -Force|Out-Null

Set-AzureStorageBlobContent -Container $templateContainerName -File keyvault.chinanorth.parameters.json -Context $ctx -Force|Out-Null
Set-AzureStorageBlobContent -Container $templateContainerName -File network.chinanorth.parameters.json -Context $ctx -Force|Out-Null
#Set-AzureStorageBlobContent -Container $templateContainerName -File applicationsystem.eastasia.parameters.json -Context $ctx
Set-AzureStorageBlobContent -Container $templateContainerName -File shared-resource.json -Context $ctx -Force|Out-Null
Set-AzureStorageBlobContent -Container $templateContainerName -File siteapplication.json -Context $ctx -Force|Out-Null
Set-AzureStorageBlobContent -Container $templateContainerName -File applicationjumpbox.json -Context $ctx -Force|Out-Null
Set-AzureStorageBlobContent -Container $templateContainerName -File empty-resource.json -Context $ctx -Force|Out-Null
Write-Host "completed!"
#publish DSC configuration
#Publish-AzureRmVMDscConfiguration -ResourceGroupName $RGNameTemplate -StorageAccountName $StgAcctName -ContainerName $templateContainerName -StorageEndpointSuffix $storageEndpointSuffix -ConfigurationPath JumpboxDscConfiguration.ps1
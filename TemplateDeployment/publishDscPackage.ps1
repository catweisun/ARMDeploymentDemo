Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$RGNameDSCConfiguration = "RG-ARM-Demo-DSC"
$StgAcctName = "ARMDemoDSCStorage".ToLower()
$dscContainerName = "dscconfiguration"
$loc = "China North"
$storageEndpointSuffix = "core.chinacloudapi.cn"
#prepare resource group
#New-AzureRmResourceGroup -Name $RGNameDSCConfiguration -Location $loc
#prepare storage account and container
#New-AzureRmStorageAccount -ResourceGroupName $RGNameDSCConfiguration -Name $StgAcctName -Type Standard_LRS -Location $loc
$key = (Get-AzureRmStorageAccountKey -ResourceGroupName $RGNameDSCConfiguration -Name $StgAcctName).Key1
$ctx = New-AzureStorageContext -StorageAccountName $StgAcctName -StorageAccountKey $key
#New-AzureStorageContainer -Name $dscContainerName -Permission Blob -Context $ctx 
Azure\Remove-AzureStorageBlob -Blob "JumpboxDscConfiguration.ps1.zip" -Container $dscContainerName -Context $ctx
#publish DSC configuration
Publish-AzureRmVMDscConfiguration -ResourceGroupName $RGNameDSCConfiguration -StorageAccountName $StgAcctName -ContainerName $dscContainerName -StorageEndpointSuffix $storageEndpointSuffix -ConfigurationPath JumpboxDscConfiguration.ps1
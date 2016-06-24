Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$RGNameARMDemoJumpbox ="RG-ARM-Demo-Jumpbox"
Remove-AzureRmResourceGroup -Name $RGNameARMDemoJumpbox -Force


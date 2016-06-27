Login-AzureRmAccount -EnvironmentName AzureChinaCloud
Select-AzureRmSubscription -SubscriptionId 27621395-3c2d-47e0-9734-102ef2b38b08 
$RGNameARMDemoJumpbox ="RG-ARM-Demo-Jumpbox"
Remove-AzureRmResourceGroup -Name $RGNameARMDemoJumpbox -Force


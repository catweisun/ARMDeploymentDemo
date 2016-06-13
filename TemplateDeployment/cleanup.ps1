Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$RGNameARMDemoJumpbox ="RG-ARM-Demo-Jumpbox"
Get-AzureRmResource |?{$_.ResourceGroupName -eq $RGNameARMDemoJumpbox} | Remove-AzureRmResource -Force


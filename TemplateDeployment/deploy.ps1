Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$RGNameARMDemoJumpbox ="RG-ARM-Demo-Jumpbox"
$templateUri = "https://raw.githubusercontent.com/catweisun/ARMDeploymentDemo/master/TemplateDeployment/azuredeploy.json"
$templateParameterUri ="https://github.com/catweisun/ARMDeploymentDemo/blob/master/TemplateDeployment/azuredeploy.parameters.json"
$loc = "China North"
Select-AzureRmSubscription -SubscriptionId 27621395-3c2d-47e0-9734-102ef2b38b08 
New-AzureRmResourceGroup -Name $RGNameARMDemoJumpbox -Location $loc -Force
$beginTime = Get-Date
#New-AzureRmResourceGroupDeployment -Name "AzureDemoJumpbox" -ResourceGroupName $RGNameARMDemoJumpbox -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri
New-AzureRmResourceGroupDeployment -Name "AzureDemoJumpboxDeployment" -ResourceGroupName $RGNameARMDemoJumpbox -TemplateFile azuredeploy.json -TemplateParameterFile azuredeploy.parameters.json
$endTime = Get-Date

$totalSeconds = ($endTIme-$beginTime).TotalSeconds
Write-Host "Total use " $totalSeconds
Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$RGNameNetwork = "RG-ARM-BP-Network"
$RGNameARMDemoJumpbox ="RG-ARM-Demo-Jumpbox"
$templateUri = "https://raw.githubusercontent.com/catweisun/ARMDeploymentDemo/master/TemplateDeployment/azuredeploy.json"
$templateParameterUri ="https://github.com/catweisun/ARMDeploymentDemo/blob/master/TemplateDeployment/azuredeploy.parameters.json"
$loc = "China North"
New-AzureRmResourceGroup -Name $RGNameARMDemoJumpbox -Location $loc
#New-AzureRmResourceGroupDeployment -Name "AzureDemoJumpbox" -ResourceGroupName $RGNameARMDemoJumpbox -TemplateUri $templateUri -TemplateParameterUri $templateParameterUri
New-AzureRmResourceGroupDeployment -Name "AzureDemoJumpbox" -ResourceGroupName $RGNameARMDemoJumpbox -TemplateFile azuredeploy.json -TemplateParameterFile azuredeploy.parameters.json
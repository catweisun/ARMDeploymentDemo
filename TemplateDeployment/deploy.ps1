Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$RGNameNetwork = "RG-ARM-BP-Network"
$RGNameARMDemoJumpbox ="RG-ARM-Demo-Jumpbox"
$loc = "China North"
New-AzureRmResourceGroup -Name $RGNameARMDemoJumpbox -Location $loc
New-AzureRmResourceGroupDeployment -Name "AzureDemoJumpbox" -ResourceGroupName $RGNameARMDemoJumpbox -TemplateFile azuredeploy.json -TemplateParameterFile azuredeploy.parameters.json
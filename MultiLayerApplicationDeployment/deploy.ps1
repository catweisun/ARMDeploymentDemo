param(
    [Parameter(Mandatory=$true)]
    [string]
    $RGNamePlaceHolder,
    [Parameter(Mandatory=$true)]
    [Boolean]
    $IsLocalTemplate = $true
)
Login-AzureRmAccount -EnvironmentName AzureChinaCloud
$TemplateBaseUri = "https://raw.githubusercontent.com/catweisun/ARMDeploymentDemo/master/MultiLayerApplicationDeployment/"
if($IsLocalTemplate)
{
    $TemplateBaseUri = $pwd.Path +"\"
    Write-Host $TemplateBaseUri
}
$RGNameNetwork = "RG-ARM-HOL-"+$RGNamePlaceHolder+"-Network"
$RGNameApplication ="RG-ARM-HOL-"+$RGNamePlaceHolder+"-Application"
$RGNameKV = "RG-ARM-HOL-"+$RGNamePlaceHolder+"-KV"
$RGList = @($RGNameApplication,$RGNameNetwork,$RGNameKV)
$networkTemplate = $TemplateBaseUri+"network.json"
$networkTemplateParameter=$TemplateBaseUri+"network.paramters.json"
$loc = "China North"
#Deploy resource groups
$RGList|ForEach-Object -Process { 
    New-AzureRmResourceGroup -Name $_ -Location $loc
    Write-Host -ForegroundColor Green "Resource Group " $_ " created."
 } 

#New-AzureRmResourceGroup -Name $RG
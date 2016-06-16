param(
    [Parameter(Mandatory=$true)]
    [string]
    $RGNamePlaceHolder,
    [Parameter(Mandatory=$true)]
    [string]
    $Location,
    [Parameter(Mandatory=$true)]
    [Boolean]
    $IsLocalTemplate = $true
)
#$loc = "China North"
$locsubffix = $Location.Replace(" ","").ToLower()

$TemplateBaseUri = "https://raw.githubusercontent.com/catweisun/ARMDeploymentDemo/master/MultiLayerApplicationDeployment/"
if($IsLocalTemplate)
{
    $TemplateBaseUri = $pwd.Path +"\"
}
Write-Host $TemplateBaseUri
$EnvSecureStore = @{"Seq"=1;"RGNameSuffix"="KV";"ScriptName"="keyvault"}
$EnvNetwork = @{"Seq"=2;"RGNameSuffix"="Network";"ScriptName"="network"}
$EnvApplication = @{"Seq"=3;"RGNameSuffix"="Application";"ScriptName"="application"}
$resources = $EnvSecureStore,$EnvNetwork,$EnvApplication
#Login-AzureRmAccount -EnvironmentName AzureChinaCloud
if($Location.ToLower() -like "*china*")
{
    Login-AzureRmAccount -EnvironmentName AzureChinaCloud
}
else {
    Login-AzureRmAccount
    Select-AzureRmSubscription -SubscriptionId 812441bb-dd47-463f-8ded-fcc8c95f9754 
}

$resources|Sort-Object -Property{$_.Seq}|foreach{
    $RGName = "RG-ARM-HOL-"+$RGNamePlaceHolder+"-"+$_.RGNameSuffix
    $RGTemplate = $TemplateBaseUri+$_.ScriptName+".json"
    $RGTemplateParameter = $TemplateBaseUri+$_.ScriptName+"."+$locsubffix+".parameters.json"
    $DeploymentName = "Deployment-"+$RGNamePlaceHolder+"-"+$_.RGNameSuffix
    New-AzureRmResourceGroup -Name $RGName -Location $Location
    Write-Host -ForegroundColor Green "Resource Group" $RGName "created."
    if($IsLocalTemplate)
    {
        Write-Host "Using local template " 
        Write-Host $RGTemplate
        Write-Host $RGTemplateParameter 
        New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RGName -TemplateFile $RGTemplate -TemplateParameterFile $RGTemplateParameter #-NamePlaceHolder $RGNamePlaceHolder   
     }
    else {
        Write-Host "Using remote template"
        Write-Host $RGTemplate
        Write-Host $RGTemplateParameter
        #New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RGName -TemplateUri $RGTemplate -TemplateParameterUri $RGTemplateParameter #-NamePlaceHolder $RGNamePlaceHolder          
    }
    Write-Host -ForegroundColor Green "Deploy" $DeploymentName "is completed". 
}
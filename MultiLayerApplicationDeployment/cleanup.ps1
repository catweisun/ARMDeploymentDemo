param(
    [Parameter(Mandatory=$true)]
    [string]
    $location
)
if($location -like "*china*")
{
    Login-AzureRmAccount -EnvironmentName AzureChinaCloud
}
else {
    Login-AzureRmAccount
    Select-AzureRmSubscription -SubscriptionId 812441bb-dd47-463f-8ded-fcc8c95f9754 
}
Get-AzureRmResourceGroup |?{$_.ResourceGroupName -like "RG-ARM-HOL-*"}|foreach -Process{
    $RGName = $_.ResourceGroupName
    Remove-AzureRmResourceGroup -Name $RGName -Force
    Write-Host -ForegroundColor Red "Resource Group "$RGName" deleted."
}
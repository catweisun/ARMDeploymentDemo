Login-AzureRmAccount -EnvironmentName AzureChinaCloud
Get-AzureRmResourceGroup |?{$_.ResourceGroupName -like "RG-ARM-HOL-*"}|foreach -Process{
    $RGName = $_.ResourceGroupName
    Get-AzureRmResource|?{$_.ResourceGroupName -eq $RGName} | Remove-AzureRmResource -Force
    Remove-AzureRmResourceGroup -Name $RGName -Force
    Write-Host -ForegroundColor Red "Resource Group "$RGName" deleted."
}
workflow StartJumpboxVM {
    $cred = Get-AutomationPSCredential -Name AzureLogin 
    Login-AzureRmAccount -EnvironmentName AzureChinaCloud -Credential $cred
    Get-AzureRmVM -ResourceGroupName RG-ARM-Demo-Jumpbox|Start-AzureRmVM    
}
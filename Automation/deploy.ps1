param(
    # Parameter help description
    [Parameter(Mandatory=$True)]
    [string]
    $AutomationAccountName
)
$cred = Get-Credential
$loc = "China North"
$acctNamePrefix = "armdemo-"
$acctName = $acctNamePrefix + $AutomationAccountName
Add-AzureAccount -Environment AzureChinaCloud -Credential $cred
New-AzureAutomationAccount -Name $acctName -Location $loc
Write-Host -ForegroundColor Green "Automation Account " $acctName " created."
New-AzureAutomationCredential -Name AzureLogin -Value $cred -AutomationAccountName $acctName -Description "Azure China Login"
Write-Host -ForegroundColor Green "Credential AzureLogin created."  
$subId = (Get-AzureSubscription -Current).SubscriptionId 
New-AzureAutomationVariable -Name "ManagedSubId" -Value $subId -AutomationAccountName $acctName -Description "Managed SubscriptionId" -Encrypted $false
New-AzureAutomationRunbook -Path StopJumpboxVM.ps1 -Description "Stop Jumpbox VM" -AutomationAccountName $acctName
Publish-AzureAutomationRunbook -Name StopJumpboxVM -AutomationAccountName $acctName
Write-Host -ForegroundColor Green "Runbook StopJumpboxVM created"
New-AzureAutomationRunbook -Path StartJumpboxVM.ps1 -Description "Start Jumpbox VM " -AutomationAccountName $acctName
Publish-AzureAutomationRunbook -Name StartJumpboxVM -AutomationAccountName $acctName
Write-Host -ForegroundColor Green "Runbook StartJumpboxVM created"  
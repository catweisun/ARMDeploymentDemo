Add-AzureAccount -Environment AzureChinaCloud
Get-AzureAutomationAccount|?{$_.AutomationAccountName -like "armdemo-*"}| Remove-AzureAutomationAccount -Force
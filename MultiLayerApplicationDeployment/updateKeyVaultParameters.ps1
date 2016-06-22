param(
    [Parameter(Mandatory=$true)]
    [string]
    $FilePath
)
$tenantId = (Get-AzureRmContext).Tenant.TenantId      
$objectId = (Get-AzureRmADUser -UserPrincipalName (Get-AzureRmContext).Account)[0].Id

(Get-Content -Path $FilePath).Replace('{objectId}',$objectId).Replace('{tenantId}',$tenantId)|Set-Content -Path $FilePath
Write-Host -ForegroundColor Green  $FilePath "is updated for objectId "$objectId "and tenantId "$tenantId

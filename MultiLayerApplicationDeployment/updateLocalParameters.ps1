param(
    [Parameter(Mandatory=$true)]
    [string]
    $NamePlaceHolder,
    [Parameter(Mandatory=$true)]
    [string]
    $FilePath
)
(Get-Content -Path $FilePath).Replace('{NamePlaceHolder}',$NamePlaceHolder)|Set-Content -Path $FilePath
Write-Host -ForegroundColor Green  $FilePath "is updated for "$NamePlaceHolder

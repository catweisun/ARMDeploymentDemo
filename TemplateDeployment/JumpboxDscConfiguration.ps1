Configuration AzurePowershell{
 Param(
     [String[]] $NodeName = $env:COMPUTERNAME
 )
 Node $NodeName
 {
     Script downloadAzurePowerShell
    {
        GetScript = {
         $IsFileExist = Test-Path "C:\InstallFiles\azure-powershell.1.2.2.msi"
         return @{"IsFileExist" = $IsFileExist}
        }
        TestScript = {     
         return Test-Path "C:\InstallFiles\azure-powershell.1.2.2.msi"
        }
        SetScript = {
            if( -not (Test-Path "C:\InstallFiles"))
            {
                New-Item -ItemType Directory "C:\InstallFiles"
            }
            $pswebpath = "http://armdemodscstorage.blob.core.chinacloudapi.cn/dscconfiguration/azure-powershell.1.2.2.msi"
             $localpath = "C:\InstallFiles\azure-powershell.1.2.2.msi"
             Invoke-WebRequest -Uri $pswebpath -OutFile $localpath
             Unblock-File -Path $localpath
        }
    }
     Package AzurePowerShell_Installation
     {
         Ensure = "Present"
         Name = "Microsoft Azure PowerShell - March 2016"
         Path = "C:\InstallFiles\azure-powershell.1.2.2.msi"
         ProductId = "9CC296AD-833C-4521-A611-3FA93087980B"
         DependsOn = "[Script]downloadAzurePowerShell"
     }
 } 
}
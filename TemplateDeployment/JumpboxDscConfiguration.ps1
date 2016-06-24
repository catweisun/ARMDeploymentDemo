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
    Script downloadHOLFiles
    {
        GetScript = {
            $IsFileExist = (Test-Path "C:\HOL\MultiLayerAppliction") -and (Test-Path "C:\HOL\Automation" )
            return @{"IsFileExist" = $IsFileExist}
        }
        TestScript = {
               return ((Test-Path "C:\HOL\MultiLayerAppliction") -and (Test-Path "C:\HOL\Automation" ) )
        }
        SetScript = {
            if( -not (Test-Path "C:\HOL"))
            {
                New-Item -ItemType Directory "C:\HOL"
            }
            if( -not (Test-Path "C:\HOL\Automation"))
            {
                Write-Host -ForegroundCol Yellow "Create Automation Folder"
                New-Item -ItemType Directory "C:\HOL\Automation"
            }
            if( -not (Test-Path "C:\HOL\MultiLayerAppliction"))
            {
                Write-Host -ForegroundCol Yellow "Create Application Folder"
                New-Item -ItemType Directory "C:\HOL\MultiLayerApplication"
            }
            $baseUrl = "https://armdemotemplatestorage.blob.core.chinacloudapi.cn/"            
            $filelist0=@("deploy.ps1","StartJumpboxVM.ps1","StopJumpboxVM.ps1")
            $filelist1=@("applicationsystem.json","applicationsystem.chinanorth.parameters.json","deploy.ps1","keyvault.json","keyvault.chinanorth.parameters.json","network.json","network.chinanorth.parameters.json","shared-resource.json","siteapplication.json","updateKeyVaultParameters.ps1","updateLocalParameters.ps1")
            foreach($file in $filelist0)
            {
                $cnt = "automationtemplates"
                $fileuri = $baseUrl+$cnt+"/"+$file
                Write-Host -ForegroundColor Yellow $fileuri
                $localfile ="C:\HOL\Automation\"+$file  
                Invoke-WebRequest -Uri $fileuri -OutFile $localfile
                #Unblock-File -Path $localfile
            }
            foreach($file in $filelist1)
            {
                $cnt = "armtemplates"
                $fileuri = $baseUrl+$cnt+"/"+$file
                Write-Host -ForegroundColor Yellow $fileuri
                $localfile ="C:\HOL\MultiLayerApplication\"+$file 
                Invoke-WebRequest -Uri $fileuri -OutFile $localfile
            }
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
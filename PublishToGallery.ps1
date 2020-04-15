Install-Module -Name PowerShellGet -Force
Import-Module -Name PowerShellGet -Force
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Publish-Module -Path ".\UofIDMI" -Repository PSGallery -NuGetApiKey $ENV:NuGetApiKey
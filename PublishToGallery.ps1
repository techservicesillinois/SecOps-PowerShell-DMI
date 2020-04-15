Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
Publish-Module -Path ".\UofIDMI" -Repository PSGallery -NuGetApiKey $ENV:NuGetApiKey -Force
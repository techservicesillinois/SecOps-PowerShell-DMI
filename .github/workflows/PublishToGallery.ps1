try{
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Publish-Module -Path ".\UofIDMI" -Repository PSGallery -NuGetApiKey $ENV:NuGetApiKey -Force
}
catch{
    throw $_
}
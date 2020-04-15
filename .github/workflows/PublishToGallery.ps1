try{
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-Module -Name 'PSSQLite' -Force -SkipPublisherCheck
    Publish-Module -Path ".\UofIDMI" -Repository PSGallery -NuGetApiKey $ENV:NuGetApiKey -Force
}
catch{
    throw $_
}
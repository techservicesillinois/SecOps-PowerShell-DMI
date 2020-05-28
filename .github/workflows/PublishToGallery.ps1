try{
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-Module -Name 'PSDepend' -Force -SkipPublisherCheck
    Invoke-PSDepend -Path "$($PSScriptRoot)\requirements.psd1" -Force
    Publish-Module -Path ".\UofIDMI" -Repository PSGallery -NuGetApiKey $ENV:NuGetApiKey -Force
}
catch{
    throw $_
}
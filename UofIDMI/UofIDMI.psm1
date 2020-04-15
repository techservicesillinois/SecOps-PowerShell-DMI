param(
    [Boolean]$SkipDB = $False
)

[String]$FunctionPath = Join-Path -Path $PSScriptRoot -ChildPath 'Functions'
[String]$PublicFunctionPath = Join-Path -Path $FunctionPath -ChildPath 'Public'

#All function files are executed while only public functions are exported to the shell.
Get-ChildItem -Path $FunctionPath -Filter "*.ps1" -Recurse | ForEach-Object -Process {
    Write-Verbose -Message "Importing $($_.BaseName)" 
    . $_.FullName | Out-Null
}

[String]$SettingsPath = Join-Path -Path $PSScriptRoot -ChildPath 'Settings.json'
$Script:Settings = Get-Content -Path $SettingsPath | ConvertFrom-Json

[String]$Script:SQLiteDBPath = Join-Path -Path $PSScriptRoot -ChildPath 'DMI.SQLite'
[String[]]$Script:BannerOrgCodes = @()
[String[]]$Script:Deptnames = @()

if(!$SkipDB){
    #If the database does not exist it is created and the cache inserted.
    if(!(Test-Path -Path $Script:SQLiteDBPath)){
        Write-Verbose -Message 'No cache database found, creating database.'
        New-DMISQLiteDB
        Update-DMICache
    }
    elseif($Script:Settings.UpdateCacheOnImport){
        Write-Verbose -Message 'Update cache on import specified.'
        Update-DMICache
    }
    else{
        Update-DMICache -ParamCacheOnly
    }
}
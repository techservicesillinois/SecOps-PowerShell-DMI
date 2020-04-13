Import-Module -Name 'UoIDMI' -ArgumentList $True

$ModuleInfo = Get-Module -Name 'UoIDMI'
[String]$DBPath = Join-Path -Path (Split-Path -Path $ModuleInfo.Path -Parent) -ChildPath 'DMI.SQLite'

Describe 'New-DMISQLiteDB'{

    It 'Does not throw an exception when the file is absent' {
        Remove-Item -Path $DBPath -Force -ErrorAction SilentlyContinue
        { New-DMISQLiteDB -ErrorAction Stop } | Should -Not -Throw
        Remove-Item -Path $DBPath -Force -ErrorAction SilentlyContinue
    }

    It 'Does not throw an exception when the file is present' {
        New-Item -Path $DBPath -Force -ItemType File
        { New-DMISQLiteDB -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Creates a valid table' {
        (Invoke-SqliteQuery -DataSource $DBPath -Query "SELECT * FROM sqlite_master WHERE tbl_name = 'DMI' AND type = 'table'" -As DataRow -ErrorAction Stop | Measure-Object).count | Should -Be 1
    }
}
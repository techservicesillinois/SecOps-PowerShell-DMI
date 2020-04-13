[String]$ModuleRoot = Join-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -ChildPath 'UoIDMI'
Import-Module -Name $ModuleRoot -ArgumentList $True
[String]$DBPath = Join-Path -Path $ModuleRoot -ChildPath 'DMI.SQLite'

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

Describe 'Update-DMICache'{
    
    It 'Updates the database with records' {
        New-DMISQLiteDB -ErrorAction Stop
        { Update-DMICache -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Does not alter the database if ParamCacheOnly is specified' {
        New-DMISQLiteDB -ErrorAction Stop
        Update-DMICache -ErrorAction Stop
        $FirstTimestamp = Get-item -Path $DBPath
        Start-Sleep -Seconds 1
        Update-DMICache -ParamCacheOnly -ErrorAction Stop
        $SecondTimestamp = Get-item -Path $DBPath
        $FirstTimestamp.LastWriteTime -eq $SecondTimestamp.LastWriteTime | Should -Be $True
    }

    InModuleScope 'UoIDMI' {
        It 'Populates the dynamic parameter cache'{
            $Script:BannerOrgCodes.clear()
            $Script:Deptnames.clear()
            Update-DMICache -ParamCacheOnly -ErrorAction Stop

            $Script:BannerOrgCodes.count -gt 0 | Should -Be $True
            $Script:Deptnames.count -gt 0 | Should -Be $True
        }
    }
}

Describe 'Get-DMIDepartment'{
    New-DMISQLiteDB -ErrorAction Stop
    Update-DMICache -ErrorAction Stop

    It 'Returns all results if nothing is specified' {
        (Get-DMIDepartment | Measure-Object).Count -gt 1 | Should -Be $True
    }

    It 'Returns a single result from BannerOrg' {
        $SampleDepartment = (Get-DMIDepartment)[0]
        (Get-DMIDepartment -BannerOrg $SampleDepartment.Banner_Org | Measure-Object).Count -eq 1 | Should -Be $True
    }

    It 'Returns a single result from Deptname' {
        $SampleDepartment = (Get-DMIDepartment)[0]
        (Get-DMIDepartment -Deptname $SampleDepartment.Deptname | Measure-Object).Count -eq 1 | Should -Be $True
    }
}
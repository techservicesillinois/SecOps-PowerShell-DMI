[String]$ModuleRoot = Join-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -ChildPath 'UofIDMI'
Import-Module -Name $ModuleRoot -ArgumentList $True

InModuleScope 'UofIDMI' {
    Describe 'New-DMISQLiteDB'{

        It 'Does not throw an exception when the file is absent' {
            Remove-Item -Path $Script:SQLiteDBPath -Force -ErrorAction SilentlyContinue
            { New-DMISQLiteDB -ErrorAction Stop } | Should -Not -Throw
            Remove-Item -Path $Script:SQLiteDBPath -Force -ErrorAction SilentlyContinue
        }

        It 'Does not throw an exception when the file is present' {
            New-Item -Path $Script:SQLiteDBPath -Force -ItemType File
            { New-DMISQLiteDB -ErrorAction Stop } | Should -Not -Throw
        }

        It 'Creates a valid table' {
            (Invoke-SqliteQuery -DataSource $Script:SQLiteDBPath -Query "SELECT * FROM sqlite_master WHERE tbl_name = 'DMI' AND type = 'table'" -As DataRow -ErrorAction Stop | Measure-Object).count | Should -Be 1
        }
    }
}

Describe 'Update-DMICache'{
    
    It 'Updates the database with records' {
        New-DMISQLiteDB -ErrorAction Stop
        { Update-DMICache -ErrorAction Stop } | Should -Not -Throw
    }

    InModuleScope 'UofIDMI' {
        It 'Does not alter the database if ParamCacheOnly is specified' {
            New-DMISQLiteDB -ErrorAction Stop
            Update-DMICache -ErrorAction Stop
            $FirstTimestamp = Get-item -Path $Script:SQLiteDBPath
            Start-Sleep -Seconds 1
            Update-DMICache -ParamCacheOnly -ErrorAction Stop
            $SecondTimestamp = Get-item -Path $Script:SQLiteDBPath
            $FirstTimestamp.LastWriteTime -eq $SecondTimestamp.LastWriteTime | Should -Be $True
        }
    }

    InModuleScope 'UofIDMI' {
        It 'Populates the dynamic parameter cache' {
            $Script:BannerOrgCodes.clear()
            $Script:Deptnames.clear()
            Update-DMICache -ParamCacheOnly -ErrorAction Stop

            $Script:BannerOrgCodes.count -gt 0 | Should -Be $True
            $Script:Deptnames.count -gt 0 | Should -Be $True
        }
    }
}

Describe 'Get-DMIDepartment'{
    
    BeforeAll {
        New-DMISQLiteDB -ErrorAction Stop
        Update-DMICache -ErrorAction Stop
    }
    
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

    It 'Accepts pipeline input for BannerOrg' {
        $SampleDepartment = (Get-DMIDepartment)[0]
        ($SampleDepartment.Banner_Org | Get-DMIDepartment | Measure-Object).Count -eq 1 | Should -Be $True
    }

    It 'Doesn''t allow BannerOrg and Deptname together' {
        { Get-DMIDepartment -BannerOrg 'random' -Deptname 'random' } | Should -Throw
    }
}

Describe 'PSScriptAnalyzer analysis' {
    $ScriptAnalyzerRules = Get-ScriptAnalyzerRule -Name "PSAvoid*"
    $Cases = Get-ChildItem -Path $ModuleRoot -Filter "*.ps*" -Recurse | ForEach-Object -Process {
        foreach ($Rule in $ScriptAnalyzerRules) {
            @{ File = $_.FullName; Rule = $Rule }
        }
    }

    It "<File> should not return any violation for the <Rule> rule" -TestCases $Cases {
        Invoke-ScriptAnalyzer -Path $File -IncludeRule $Rule.RuleName | Should -BeNullOrEmpty
    }
}
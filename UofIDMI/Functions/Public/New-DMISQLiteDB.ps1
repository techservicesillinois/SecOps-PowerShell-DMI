<#
.Synopsis
   Creates a new instance of a SQLite database locally to store the DMI information in. This should be created automatically by the module.
.DESCRIPTION
   Creates a new instance of a SQLite database locally to store the DMI information in. This should be created automatically by the module.
.EXAMPLE
   PS C:\> New-DMISQLiteDB
#>
function New-DMISQLiteDB {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        if(Test-Path -Path $Script:SQLiteDBPath){
            Write-Verbose -Message "Existing database found. Removing $($Script:SQLiteDBPath)"
            Remove-Item -Path $Script:SQLiteDBPath -Force
        }
        
        [String]$Query = "CREATE TABLE DMI (
            Banner_Org VARCHAR(14) PRIMARY KEY,
            Legacy_Code TEXT,
            Deptname TEXT,
            deptFullName TEXT,
            deptDisplayName TEXT,
            deptDisplayName2 TEXT,
            deptDisplayName3 TEXT,
            deptDescription TEXT,
            Name TEXT,
            Address TEXT,
            Address2 TEXT,
            Mailcode TEXT,
            buildingCode TEXT,
            city TEXT,
            state TEXT,
            zip TEXT,
            areaCode TEXT,
            Phone TEXT,
            NetId TEXT,
            EndUserITSupportNetId TEXT,
            CIP TEXT,
            Comments TEXT,
            DeptType TEXT,
            Dean TEXT,
            Duplicate TEXT,
            Active TEXT,
            Campus TEXT,
            College TEXT,
            CollegeName TEXT,
            AdminRollup TEXT,
            School TEXT,
            Dept TEXT,
            URL TEXT,
            directoryDisplay TEXT
            )"

            Invoke-SqliteQuery -Query $Query -DataSource $Script:SQLiteDBPath
    }
    
    end {
        
    }
}
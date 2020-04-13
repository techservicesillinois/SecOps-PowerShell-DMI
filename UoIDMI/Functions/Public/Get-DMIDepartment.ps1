using namespace System.Management.Automation
#These classes are a necessary workaround to use variables as validate sets. Hopefully Microsoft bakes this in someday.
class ValidBannerOrgGenerator : IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        return $Script:BannerOrgCodes
    }
}

class ValidDeptnameGenerator : IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        return $Script:Deptnames
    }
}

function Get-DMIDepartment {
    [CmdletBinding()]
    param (    
        [ValidateSet( [ValidBannerOrgGenerator] )]    
        [String]$BannerOrg = '%',

        [ValidateSet( [ValidDeptnameGenerator] )]    
        [String]$Deptname = '%'
    )

    begin {
        
    }
    
    process {
        $Splat = @{
            Datasource = $Script:SQLiteDBPath
            Query = 'SELECT * FROM DMI WHERE Banner_Org like @BannerOrg AND Deptname like @Deptname'
            As = 'DataRow'
            SqlParameters = @{
                BannerOrg = $BannerOrg.Replace('*','%')
                Deptname = $Deptname.Replace('*','%')
            }
        }
        
        Invoke-SqliteQuery @Splat
    }
    
    end {
        
    }
}
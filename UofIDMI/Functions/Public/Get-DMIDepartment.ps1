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
<#
.Synopsis
   Returns the information for all departments or a specified department.
.DESCRIPTION
   Returns the information for all departments or a specified department.
.PARAMETER BannerOrg
    Banner organization code. This is an alphanumeric code in 4 sections. Ex: '1A1-NA-NA0-283'
.PARAMETER Deptname
    Plaint text department name. Ex: 'Academic Outreach'
.EXAMPLE
   PS C:\> Get-DMIDepartment

   This will return all departments.
.EXAMPLE
   PS C:\> Get-DMIDepartment -BannerOrg '1A1-NA-NA0-283'

   This will return a specific department based on banner organization code.
.EXAMPLE
    PS C:\> Get-DMIDepartment -Deptname 'Academic Outreach'

    This will return a specific department based on department name.
#>
function Get-DMIDepartment {
    [CmdletBinding(DefaultParametersetname='BannerOrg')]
    param (    
        [parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'BannerOrg')]
        [ValidateSet( [ValidBannerOrgGenerator] )]
        [Alias("owner_code")]    
        [String]$BannerOrg = '%',

        [parameter(ParameterSetName = 'Deptname')]
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
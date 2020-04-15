<#
.Synopsis
   This command will update the contents of the SQLite database created by New-DMISQLiteDB.
.DESCRIPTION
   This command will update the contents of the SQLite database created by New-DMISQLiteDB.
.PARAMETER ParamCacheOnly
    This will update the tab completion cache for Get-DMIDepartment only and not update the SQLite database.
.EXAMPLE
   PS C:\> Update-DMICache

   This will clear out and populate the SQLite database. It will also update the tab completion cache for Get-DMIDepartment.
#>
function Update-DMICache {
    [CmdletBinding()]
    param (
        [Switch]$ParamCacheOnly
    )
    
    begin {
        
    }
    
    process {
        if(!$ParamCacheOnly){
            $DMI = [System.Collections.ArrayList]@()
            $DMI += Invoke-RestMethod -Method 'Get' -Uri $Script:Settings.DMIURI -ErrorAction Stop | ConvertFrom-Csv -Delimiter "`t"

            if($DMI.count -gt 0)
            {
                Invoke-SqliteQuery -DataSource $Script:SQLiteDBPath -Query "DELETE FROM DMI"

                Invoke-SQLiteBulkCopy -DataSource $Script:SQLiteDBPath -DataTable ($DMI | Out-DataTable) -Table 'DMI' -Force
            }
        }

        $Script:BannerOrgCodes.Clear()
        $Script:Deptnames.Clear()

        $Script:BannerOrgCodes += (Get-DMIDepartment).Banner_Org
        $Script:Deptnames += (Get-DMIDepartment).Deptname
    }
    
    end {
        
    }
}
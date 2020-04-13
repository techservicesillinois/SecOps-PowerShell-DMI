function Update-DMICache {
    [CmdletBinding()]
    param (
        [Switch]$ParamCacheOnly
    )
    
    begin {
        
    }
    
    process {
        if(!$ParamCacheOnly){
            Invoke-SqliteQuery -DataSource $Script:SQLiteDBPath -Query "DELETE FROM DMI"
            
            $DMI = [System.Collections.ArrayList]@()
            $DMI += Invoke-RestMethod -Method 'Get' -Uri $Script:Settings.DMIURI | ConvertFrom-Csv -Delimiter "`t"

            Invoke-SQLiteBulkCopy -DataSource $Script:SQLiteDBPath -DataTable ($DMI | Out-DataTable) -Table 'DMI' -Force
        }

        $Script:BannerOrgCodes.Clear()
        $Script:Deptnames.Clear()

        $Script:BannerOrgCodes += (Invoke-SqliteQuery -Datasource $Script:SQLiteDBPath -Query "SELECT Banner_Org FROM DMI" -As DataRow).Banner_Org
        $Script:Deptnames += (Invoke-SqliteQuery -Datasource $Script:SQLiteDBPath -Query "SELECT Deptname FROM DMI" -As DataRow).Deptname
    }
    
    end {
        
    }
}
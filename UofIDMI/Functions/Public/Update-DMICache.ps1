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
            Write-Verbose -Message "ParamCacheOnly not specified. Refreshing database information."
            Write-Verbose -Message "Querying raw DMI information from $($Script:Settings.DMIURI)."
            $DMI = [System.Collections.ArrayList]@()
            $DMI += Invoke-RestMethod -Method 'Get' -Uri $Script:Settings.DMIURI -ErrorAction Stop | ConvertFrom-Csv -Delimiter "`t"

            if($DMI.count -gt 0)
            {
                Write-Verbose -Message "Raw data received updating database."
                Invoke-SqliteQuery -DataSource $Script:SQLiteDBPath -Query "DELETE FROM DMI"
                Invoke-SQLiteBulkCopy -DataSource $Script:SQLiteDBPath -DataTable ($DMI | Out-DataTable) -Table 'DMI' -Force
            }
            else
            {
                Throw "No data returned from $($Script:Settings.DMIURI)."
            }

            $UpdateSplat = @{
                DataSource = $Script:SQLiteDBPath
                Query = "UPDATE DMI SET EndUserITSupportNetId = CASE Banner_Org"
            }

            $TechContact = [System.Collections.ArrayList]@()
            $TechContact += Invoke-RestMethod -Method 'GET' -Uri $Script:Settings.DMIEnduserITSupportURI

            $TechContact | Where-Object -FilterScript {$Null -ne $_.NetID} | Group-Object -property  'org' | ForEach-Object -Process {
                $UpdateSplat['Query'] += " WHEN '$($_.Name)' THEN '$(($_.Group).NETID -join ',')'"
            }

            Invoke-SqliteQuery @UpdateSplat
        }

        Write-Verbose -Message 'Updating parameter cache'
        $Script:BannerOrgCodes.Clear()
        $Script:Deptnames.Clear()

        $Script:BannerOrgCodes += (Get-DMIDepartment).Banner_Org
        $Script:Deptnames += (Get-DMIDepartment).Deptname
    }
    
    end {
        
    }
}
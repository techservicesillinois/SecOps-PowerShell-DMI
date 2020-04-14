---
external help file: UofIDMI-help.xml
Module Name: UofIdmi
online version:
schema: 2.0.0
---

# Update-DMICache

## SYNOPSIS
This command will update the contents of the SQLite database created by New-DMISQLiteDB.

## SYNTAX

```
Update-DMICache [-ParamCacheOnly] [<CommonParameters>]
```

## DESCRIPTION
This command will update the contents of the SQLite database created by New-DMISQLiteDB.

## EXAMPLES

### EXAMPLE 1
```
Update-DMICache
```

This will clear out and populate the SQLite database.
It will also update the tab completion cache for Get-DMIDepartment.

## PARAMETERS

### -ParamCacheOnly
This will update the tab completion cache for Get-DMIDepartment only and not update the SQLite database.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

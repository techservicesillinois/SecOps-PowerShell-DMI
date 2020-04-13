---
external help file: UoIDMI-help.xml
Module Name: UoIDMI
online version:
schema: 2.0.0
---

# Get-DMIDepartment

## SYNOPSIS
Returns the information for all departments or a specified department.

## SYNTAX

```
Get-DMIDepartment [[-BannerOrg] <String>] [[-Deptname] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the information for all departments or a specified department.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-DMIDepartment
```

This will return all departments.

### Example 2
```powershell
PS C:\> Get-DMIDepartment -BannerOrg '1A1-NA-NA0-283'
```

This will return a specific department based on banner organization code.

### Example 3
```powershell
PS C:\> Get-DMIDepartment -Deptname 'Academic Outreach'
```

This will return a specific department based on department name.

## PARAMETERS

### -BannerOrg
Banner organization code. This is an alphanumeric code in 4 sections. Ex: '1A1-NA-NA0-283'

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Deptname
Plaint text department name. Ex: 'Academic Outreach'

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

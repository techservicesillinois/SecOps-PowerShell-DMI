---
external help file: UofIDMI-help.xml
Module Name: UofIdmi
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

### EXAMPLE 1
```
Get-DMIDepartment
```

This will return all departments.

### EXAMPLE 2
```
Get-DMIDepartment -BannerOrg '1A1-NA-NA0-283'
```

This will return a specific department based on banner organization code.

### EXAMPLE 3
```
Get-DMIDepartment -Deptname 'Academic Outreach'
```

This will return a specific department based on department name.

## PARAMETERS

### -BannerOrg
Banner organization code.
This is an alphanumeric code in 4 sections.
Ex: '1A1-NA-NA0-283'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: %
Accept pipeline input: False
Accept wildcard characters: False
```

### -Deptname
Plaint text department name.
Ex: 'Academic Outreach'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: %
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

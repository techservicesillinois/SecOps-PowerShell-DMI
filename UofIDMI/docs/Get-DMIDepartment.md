---
external help file: UofIDMI-help.xml
Module Name: UofIDMI
online version:
schema: 2.0.0
---

# Get-DMIDepartment

## SYNOPSIS
Returns the information for all departments or a specified department.

## SYNTAX

### BannerOrg (Default)
```
Get-DMIDepartment [-BannerOrg <String>] [<CommonParameters>]
```

### Deptname
```
Get-DMIDepartment [-Deptname <String>] [<CommonParameters>]
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
Parameter Sets: BannerOrg
Aliases: owner_code

Required: False
Position: Named
Default value: %
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Deptname
Plaint text department name.
Ex: 'Academic Outreach'

```yaml
Type: String
Parameter Sets: Deptname
Aliases:

Required: False
Position: Named
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

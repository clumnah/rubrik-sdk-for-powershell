---
external help file: Rubrik-help.xml
Module Name: Rubrik
online version: http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/New-RubrikSLA.html
schema: 2.0.0
---

# New-RubrikSLA

## SYNOPSIS
Creates a new Rubrik SLA Domain

## SYNTAX

```
New-RubrikSLA [-Name] <String> [[-HourlyFrequency] <Int32>] [[-HourlyRetention] <Int32>]
 [[-HourlyRetentionType] <String>] [[-DailyFrequency] <Int32>] [[-DailyRetention] <Int32>]
 [[-DailyRetentionType] <String>] [[-WeeklyFrequency] <Int32>] [[-WeeklyRetention] <Int32>]
 [[-DayOfWeek] <String>] [[-MonthlyFrequency] <Int32>] [[-MonthlyRetention] <Int32>] [[-DayOfMonth] <String>]
 [[-MonthlyRetentionType] <String>] [[-QuarterlyFrequency] <Int32>] [[-QuarterlyRetention] <Int32>]
 [[-DayOfQuarter] <String>] [[-FirstQuarterStartMonth] <String>] [[-QuarterlyRetentionType] <String>]
 [[-YearlyFrequency] <Int32>] [[-YearlyRetention] <Int32>] [[-DayOfYear] <String>] [[-YearStartMonth] <String>]
 [-AdvancedConfig] [[-BackupStartHour] <Int32>] [[-BackupStartMinute] <Int32>]
 [[-BackupWindowDuration] <Int32>] [[-FirstFullBackupStartHour] <Int32>]
 [[-FirstFullBackupStartMinute] <Int32>] [[-FirstFullBackupDay] <String>]
 [[-FirstFullBackupWindowDuration] <Int32>] [-Archival] [[-LocalRetention] <Int32>]
 [[-ArchivalLocationId] <String>] [[-PolarisID] <String>] [-InstantArchive] [-Replication]
 [[-ReplicationTargetId] <String>] [[-RemoteRetention] <Int32>] [[-Server] <String>] [[-api] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The New-RubrikSLA cmdlet will build a new SLA Domain to provide policy-driven control over protected objects within the Rubrik fabric.

## EXAMPLES

### EXAMPLE 1
```
New-RubrikSLA -SLA 'Test1' -HourlyFrequency 4 -HourlyRetention 7
```

This will create an SLA Domain named "Test1" that will take a backup every 4 hours and keep those hourly backups for 7 days.

### EXAMPLE 2
```
New-RubrikSLA -SLA 'Test1' -HourlyFrequency 4 -HourlyRetention 7 -DailyFrequency 1 -DailyRetention 30
```

This will create an SLA Domain named "Test1" that will take a backup every 4 hours and keep those hourly backups for 7 days
while also keeping one backup per day for 30 days.

### EXAMPLE 3
```
New-RubrikSLA -SLA 'Test1' -AdvancedConfig -HourlyFrequency 4 -HourlyRetention 7 -DailyFrequency 1 -DailyRetention 30 -WeeklyFrequency 1 -WeeklyRetention 4 -DayOfWeek Friday -YearlyFrequency 1 -YearlyRetention 3 -DayOfYear LastDay -YearStartMonth February
```

This will create an SLA Domain named "Test1" that will take a backup every 4 hours and keep those hourly backups for 7 days
while also keeping one backup per day for 30 days, one backup per week for 4 weeks and one backup per year for 3 years. 
The weekly backups will be created on Fridays and the yearly backups will be created on January 31 because the year is set
to start in February.
The advanced SLA configuration can only be used with CDM version 5.0 and above.

### EXAMPLE 4
```
New-RubrikSLA -SLA 'Test1' -HourlyFrequency 4 -HourlyRetention 7 -DailyFrequency 1 -DailyRetention 30 -BackupStartHour 22 -BackupStartMinute 00 -BackupWindowDuration 8
```

This will create an SLA Domain named "Test1" that will take a backup every 4 hours and keep those hourly backups for 7 days. 
Backups are allowed to run between 22:00 and 6:00AM.

### EXAMPLE 5
```
New-RubrikSLA -SLA 'Test1' -HourlyFrequency 4 -HourlyRetention 7 -DailyFrequency 1 -DailyRetention 30 -FirstFullBackupStartHour 21 -FirstFullBackupStartMinute 30 -FirstFullBackupWindowDuration 57 -FirstFullBackupDay Friday
```

This will create an SLA Domain named "Test1" that will take a backup every 4 hours and keep those hourly backups for 7 days. 
The first full backup is allowed to be taken between Friday 21:30 and Monday 6:30AM.

### EXAMPLE 6
```
New-RubrikSLA -SLA 'Test1' -HourlyFrequency 4 -HourlyRetention 7 -DailyFrequency 1 -DailyRetention 30 -Archival -ArchivalLocationId 53aef5df-b628-4b61-aade-6520a2a5ba4d -LocalRetention 14 -InstantArchive
```

This will create an SLA Domain named "Test1" that will take a backup every 4 hours and keep those hourly backups for 7 days,
while also keeping one backup per day for 30 days.
At the same time, data is immediately copied to the specified archival location 
and will be kept there for 14 days.

### EXAMPLE 7
```
New-RubrikSLA -SLA 'Test1' -HourlyFrequency 4 -HourlyRetention 7 -DailyFrequency 1 -DailyRetention 30 -Replication -ReplicationTargetId 8b4fe6f6-cc87-4354-a125-b65e23cf8c90 -RemoteRetention 5
```

This will create an SLA Domain named "Test1" that will take a backup every 4 hours and keep those hourly backups for 7 days,
while also keeping one backup per day for 30 days.
At the same time, data is replicated to the specified target cluster 
and will be kept there for 5 days.

## PARAMETERS

### -Name
SLA Domain Name

```yaml
Type: String
Parameter Sets: (All)
Aliases: SLA

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HourlyFrequency
Hourly frequency to take snapshots

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -HourlyRetention
Number of days or weeks to retain the hourly snapshots.
For CDM versions prior to 5.0 this value must be set in days

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -HourlyRetentionType
Retention type to apply to hourly snapshots when $AdvancedConfig is used.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Daily
Accept pipeline input: False
Accept wildcard characters: False
```

### -DailyFrequency
Daily frequency to take snapshots

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DailyRetention
Number of days or weeks to retain the daily snapshots.
For CDM versions prior to 5.0 this value must be set in days

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DailyRetentionType
Retention type to apply to daily snapshots when $AdvancedConfig is used.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Daily
Accept pipeline input: False
Accept wildcard characters: False
```

### -WeeklyFrequency
Weekly frequency to take snapshots

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WeeklyRetention
Number of weeks to retain the weekly snapshots

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DayOfWeek
Day of week for the weekly snapshots when $AdvancedConfig is used.
The default is Saturday.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: Saturday
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyFrequency
Monthly frequency to take snapshots

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyRetention
Number of months, quarters or years to retain the monthly backups.
For CDM versions prior to 5.0, this value must be set in years

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DayOfMonth
Day of month for the monthly snapshots when $AdvancedConfig is used.
The default is the last day of the month.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: LastDay
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonthlyRetentionType
Retention type to apply to monthly snapshots.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: Monthly
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuarterlyFrequency
Quarterly frequency to take snapshots.
Does not apply to CDM versions prior to 5.0

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuarterlyRetention
Number of quarters or years to retain the monthly snapshots.
Does not apply to CDM versions prior to 5.0

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DayOfQuarter
Day of quarter for the quarterly snapshots when $AdvancedConfig is used.
The default is the last day of the quarter.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: LastDay
Accept pipeline input: False
Accept wildcard characters: False
```

### -FirstQuarterStartMonth
Month that starts the first quarter of the year for the quarterly snapshots when $AdvancedConfig is used.
The default is January.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: January
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuarterlyRetentionType
Retention type to apply to quarterly snapshots.
The default is Quarterly.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: Quarterly
Accept pipeline input: False
Accept wildcard characters: False
```

### -YearlyFrequency
Yearly frequency to take snapshots

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -YearlyRetention
Number of years to retain the yearly snapshots

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DayOfYear
Day of year for the yearly snapshots when $AdvancedConfig is used.
The default is the last day of the year.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: LastDay
Accept pipeline input: False
Accept wildcard characters: False
```

### -YearStartMonth
Month that starts the first quarter of the year for the quarterly snapshots when $AdvancedConfig is used.
The default is January.
Does not apply to CDM versions prior to 5.0

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: January
Accept pipeline input: False
Accept wildcard characters: False
```

### -AdvancedConfig
Whether to turn advanced SLA configuration on or off.
Does not apply to CDM versions prior to 5.0

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

### -BackupStartHour
{{ Fill BackupStartHour Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackupStartMinute
Minute of hour from which backups are allowed to run

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackupWindowDuration
Number of hours during which backups are allowed to run

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FirstFullBackupStartHour
Hour from which the first full backup is allowed to run.
Uses the 24-hour clock

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FirstFullBackupStartMinute
Minute of hour from which the first full backup is allowed to run

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FirstFullBackupDay
{{ Fill FirstFullBackupDay Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FirstFullBackupWindowDuration
Number of hours during which the first full backup is allowed to run

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archival
Whether to enable archival

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

### -LocalRetention
Time in days to keep backup data locally on the cluster.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ArchivalLocationId
ID of the archival location

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolarisID
Polaris Managed ID

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstantArchive
Whether to enable Instant Archive

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

### -Replication
Whether to enable replication

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

### -ReplicationTargetId
ID of the replication target

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoteRetention
Time in days to keep data on the replication target.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Rubrik server IP or FQDN

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: $global:RubrikConnection.server
Accept pipeline input: False
Accept wildcard characters: False
```

### -api
API version

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: $global:RubrikConnection.api
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Written by Chris Wahl for community usage
Twitter: @ChrisWahl
GitHub: chriswahl

## RELATED LINKS

[http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/New-RubrikSLA.html](http://rubrikinc.github.io/rubrik-sdk-for-powershell/reference/New-RubrikSLA.html)


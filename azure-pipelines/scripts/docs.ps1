# Create new markdown and XML help files
Write-Output 'Building new function documentation'

$MarkdownFiles = New-MarkdownHelp -Module Rubrik -OutputFolder "$env:LocalPath\docs\reference\" -Force | Measure-Object | Select-Object -ExpandProperty Count
Write-Output "Created $MarkdownFiles markdown help files in '$env:LocalPath\docs\reference\'"

$ExternalHelp = New-ExternalHelp -Path "$env:LocalPath\docs\reference\" -OutputPath "$env:LocalPath\Rubrik\en-US\" -Force
Write-Output "Created $($ExternalHelp.Name) external help file in '$env:LocalPath\Rubrik\en-US\'"

# Custom Generate Summary.md
Write-Output 'Generate custom markdown SUMMARY.md'
$MarkDown = "# Rubrik SDK for PowerShell`n`n"
$MarkDown += "## User Documentation`n`n"

# Documentation folder
Get-ChildItem -LiteralPath "$env:LocalPath\docs\documentation" | ForEach-Object -Process {
    $Reference = switch ($_.BaseName) {
        'Requirements' {'Requirements'}
        'Installation' {'Installation'}
        'Getting_Started' {'Getting Started'}
        'Project_Architecture' {'Project Architecture'}
        'Support' {'Support'}
        'Contribution' {'Contribution'}
        'Licensing' {'Licensing'}
        'FAQ' {'FAQ'}
        default {$_}
    }
    $uri = "$($_.Directory.BaseName)/$($_.Name)"
    $MarkDown += "* [$Reference]($uri)`n"
} -End {
    $MarkDown += "`n----`n`n"
}

$MarkDown += "## User Documentation`n`n"

# Workflow folder
Get-ChildItem -LiteralPath "$env:LocalPath\docs\workflow" | ForEach-Object -Begin {
    $MarkDown += "* [Workflow](workflow/readme.md)`n"
} -Process {
    $Reference = switch ($_.BaseName) {
        'flow_audit' {'Flow Audit'}
        default {$_}
    }
    $uri = "$($_.Directory.BaseName)/$($_.Name)"

    if ($_.basename -ne 'readme') {
        $MarkDown += "    * [$Reference]($uri)`n"
    }
} -End {
    $MarkDown += "`n"
}

# Reference folder
Get-ChildItem -LiteralPath "$env:LocalPath\docs\reference" | ForEach-Object -Begin {
    $MarkDown += "* [Reference](workflow/readme.md)`n"
} -Process {
    $Reference = switch ($_.BaseName) {
        default {$_}
    }
    $uri = "$($_.Directory.BaseName)/$($_.Name)"
    
    if ($_.basename -ne 'readme') {
        $MarkDown += "    * [$Reference]($uri)`n"
    }
}

# Write Markdown to file
Set-Content -Value $MarkDown -Path "$env:LocalPath\docs\SUMMARY.md"

# End message
Write-Output 'Completed GitBook documentation generation'
﻿# We're going to add 1 to the revision value since a new commit has been merged to Master
# This means that the major / minor / build values will be consistent across GitHub and the Gallery
try {
    # This is where the module manifest lives
    $manifestPath = "$env:LocalPath\Rubrik\Rubrik.psd1"

    # Start by importing the manifest to determine the version, then add 1 to the revision
    $manifest = Test-ModuleManifest -Path $manifestPath
    [System.Version]$version = $manifest.Version
    Write-Output "Old Version: $version"

    if ($env:TargetBranch -ne 'master') {
        $WebRequestSplat = @{
            Uri = 'https://raw.githubusercontent.com/rubrikinc/rubrik-sdk-for-powershell/devel/Rubrik/Rubrik.psd1'
            UseBasicParsing = $true
            ErrorAction = 'Stop'
        }
        $version = (Invoke-WebRequest @WebRequestSplat) -split '\n' -match 'ModuleVersion' -replace "\s|'|ModuleVersion|="
        $version = [version][string]$version
        [String]$newVersion = "$($version.Major).$($version.Minor).$($manifest.version.revision+1)"
        Write-Output "New Version: $newVersion"
    else {
        $newVersion = $manifest.Version
    }

    # Update the manifest with the new version value and fix the weird string replace bug
    $functionList = ((Get-ChildItem -Path .\Rubrik\Public).BaseName)
    $splat = @{
        'Path'              = $manifestPath
        'ModuleVersion'     = $newVersion
        'FunctionsToExport' = $functionList
        'Copyright'         = "(c) 2015-$( (Get-Date).Year ) Rubrik, Inc. All rights reserved."
    }
    Update-ModuleManifest @splat
    (Get-Content -Path $manifestPath) -replace 'PSGet_Rubrik', 'Rubrik' | Set-Content -Path $manifestPath
    (Get-Content -Path $manifestPath) -replace 'NewManifest', 'Rubrik' | Set-Content -Path $manifestPath
    (Get-Content -Path $manifestPath) -replace 'FunctionsToExport = ', 'FunctionsToExport = @(' | Set-Content -Path $manifestPath -Force
    (Get-Content -Path $manifestPath) -replace "$($functionList[-1])'", "$($functionList[-1])')" | Set-Content -Path $manifestPath -Force
} catch {
    throw $_
}

# Import Module
Import-Module -Name "$env:LocalPath\Rubrik\Rubrik.psd1" -Force

. .\azure-pipelines\scripts\docs.ps1
Write-Host -Object ''

if ($env:TargetBranch -eq 'master') {
    try {
        # Build a splat containing the required details and make sure to Stop for errors which will trigger the catch
        $PublishSplat = @{
            Path        = "$env:LocalPath\Rubrik"
            NuGetApiKey = $env:GalleryAPIKey
            ErrorAction = 'Stop'
        }
        Publish-Module @PublishSplat
        Write-Host "Rubrik PowerShell Module version $newVersion published to the PowerShell Gallery." -ForegroundColor Cyan
    } catch {
        # Sad panda; it broke
        Write-Warning "Publishing update $newVersion to the PowerShell Gallery failed."
        throw $_
    }
} elseif ($env:TargetBranch -eq 'devel') {
    # todo, prerelease deployments for devel
}

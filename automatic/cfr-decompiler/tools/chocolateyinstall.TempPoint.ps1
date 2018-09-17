$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$jarPath = Join-Path -Path $toolsDir -ChildPath 'cfr.jar'
$versionStr = $env:ChocolateyPackageVersion -replace '^(\d+)\.(\d+).*','$1_$2'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileFullPath  = $jarPath
    url           = "http://www.benf.org/other/cfr/cfr_$versionStr.jar"
    checksum      = 'b66a1e59891a2585885b171b4ec6fcc0e20f0d419e90a153e5c01540bb1cc67f'
    checksumType  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

[array]$javaCmds = Get-Command -Name java
if ($javaCmds[0] -eq $null -or $javaCmds[0].CommandType -ne 'Application')
{
    throw 'Unexpected Java location'
}
Install-Binfile -Name $env:ChocolateyPackageName -Path $javaCmds[0].Definition -Command "`"-jar $jarPath`""

$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$jarPath = Join-Path -Path $toolsDir -ChildPath 'cfr-decompiler.jar'
$url = 'http://www.benf.org/other/cfr/cfr_0_132.jar'
$checksum = '2cd4d7a70b2b9cff3b3d330836fbfb6d'

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileFullPath  = $jarPath
    url           = $url
    checksum      = $checksum
    checksumType  = 'md5'
}
Get-ChocolateyWebFile @packageArgs

[array]$javaCmds = Get-Command -Name java
if ($javaCmds[0] -eq $null -or $javaCmds[0].CommandType -ne 'Application')
{
    throw 'Unexpected Java location'
}
Install-Binfile -Name $env:ChocolateyPackageName -Path $javaCmds[0].Definition -Command "`"-jar $jarPath`""

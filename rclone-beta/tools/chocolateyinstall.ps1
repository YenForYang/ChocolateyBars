$ErrorActionPreference = 'Stop';
$packageName= 'rclone-beta'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://beta.rclone.org/rclone-beta-latest-windows-386.zip'
$url64 = 'http://beta.rclone.org/rclone-beta-latest-windows-amd64.zip'
$html = $(Invoke-Webrequest -Uri 'http://beta.rclone.org/')
$env:ChocolateyPackageVersion = $html.ParsedHtml.getElementsByTagName('A') | ?{ $_.outerHtml -match 'v.\...-.*' } | ?{ $_.innerText.length -eq ($html.ParsedHtml.getElementsByTagName('A') | ?{ $_.outerHtml -match 'v.\...-.*' } | %{ $_.innerText.length } | sort | select -last 1) } | % innerText | sort | select -last 1 | %{ $_ -replace '.{10}$' -replace '-', '.' }
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64
  softwareName  = 'rclone*'
  checksum      = $html.ParsedHtml.getElementsByTagName('TD') | select -Last 1 -Skip 5 | % innerText
  checksumType  = 'md5'
  checksum64    = $html.ParsedHtml.getElementsByTagName('TD') | select -Last 1 | % innerText
  checksumType64= 'md5'	
}
Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64

﻿$ErrorActionPreference = 'Stop';

$packageName= 'rclone-beta'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://beta.rclone.org/rclone-beta-latest-windows-386.zip'
$url64 = 'http://beta.rclone.org/rclone-beta-latest-windows-amd64.zip'

$html = $(Invoke-Webrequest -Uri 'http://beta.rclone.org/')
$html.ParsedHtml.getElementsByTagName('TD') | Select-Object -Last 1 -Skip 5 | % { $checksum = $_.innerText }
$html.ParsedHtml.getElementsByTagName('TD') | Select-Object -Last 1 | % { $checksum64 = $_.innerText }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'rclone*'
	
  checksum      = $checksum

  checksumType  = 'md5'
  checksum64    = $checksum64
  checksumType64= 'md5'	
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64

$ErrorActionPreference = 'Stop';

$packageName= 'rclone'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://beta.rclone.org/rclone-beta-latest-windows-386.zip'
$url64      = 'http://beta.rclone.org/rclone-beta-latest-windows-amd64.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'rclone*' 

  checksum      = '3362f1cafd7cc33e651b16959ca55e4d'
  checksumType  = 'md5'
  checksum64    = 'e313520b9430ed1a211e8769d38ef168'
  checksumType64= 'md5'
	
}

Install-ChocolateyZipPackage $packageName $url $toolsDir [$url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64]

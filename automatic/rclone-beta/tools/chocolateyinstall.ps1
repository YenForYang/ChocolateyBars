
$ErrorActionPreference = 'Stop'

$packageName= 'rclone-beta'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url32 = 'http://beta.rclone.org/v1.40-140-gd997418b-opendrive/rclone-v1.40-140-gd997418b-opendrive-windows-386.zip'
$url64 = 'http://beta.rclone.org/v1.40-140-gd997418b-opendrive/rclone-v1.40-140-gd997418b-opendrive-windows-amd64.zip'

$checksum32 = '39a7c92e12769d8107a54aa510505462'
$checksum64 = '480b59acf72ed08a24eabd7c71d85404'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = $url32
  url64bit      = $url64
  softwareName  = 'rclone*'
  checksum      = $checksum32
  checksum64    = $checksum64
}
Install-ChocolateyZipPackage `
							 -PackageName $packageName `
							 -Url $url32 `
							 -UnzipLocation $toolsDir `
							 -Url64bit $url64 `
							 -Checksum $checksum32 `
							 -Checksum64 $checksum64


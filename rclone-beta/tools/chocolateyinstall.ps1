
$ErrorActionPreference = 'Stop'

$packageName= 'rclone-beta'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url32 = 'http://beta.rclone.org/v1.43-076-ga2587517-beta/rclone-v1.43-076-ga2587517-beta-windows-386.zip'
$url64 = 'http://beta.rclone.org/v1.43-076-ga2587517-beta/rclone-v1.43-076-ga2587517-beta-windows-amd64.zip'

$checksum32 = '65fa412c2f59baa48348d353082bb8b9'
$checksum64 = '3590176914087c00e57b54ed1201e61f'

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


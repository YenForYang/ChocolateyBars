import-module au
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
function global:au_SearchReplace {
	@{
		'tools\chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"       = "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
			"(^[$]url64\s*=\s*)('.*')"	      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
		}
	}
}
#$checkdl = $(Invoke-WebRequest -Uri "http://beta.rclone.org/$env:ChocolateyPackageVersion" -UseBasicParsing).content.contains('-windows-amd64.zip')
function global:au_GetLatest
{
	$html = Invoke-Webrequest -Uri 'http://beta.rclone.org/' -UseBasicParsing
	$version = $html -split 'href="./v', 0, 'simplematch' -split '/">', 0, 'simplematch' | where { $_.length -gt 15 -and $_.length -lt 99 } | select -last 1
	$url32 = "http://beta.rclone.org/v$version/rclone-v${version}-windows-386.zip"
	$url64 = "http://beta.rclone.org/v$version/rclone-v${version}-windows-amd64.zip"
	$finalVersion = "$($version.split('-', 3)[0, 1] -join '.')-beta"
	
	@{ URL32 = $url32; URL64 = $url64; Version = $finalVersion; ChecksumType32 = 'md5'; ChecksumType64 = 'md5' }
}

update -ChecksumFor all -NoReadme

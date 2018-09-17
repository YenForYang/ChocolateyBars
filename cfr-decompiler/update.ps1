import-module au
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function global:au_SearchReplace
{
	@{
		'tools\chocolateyInstall.ps1'  = @{
			"(^[$]url\s*=\s*)('.*')"	    = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
		}
	}
}
#$checkdl = $(Invoke-WebRequest -Uri "http://beta.rclone.org/$env:ChocolateyPackageVersion" -UseBasicParsing).content.contains('-windows-amd64.zip')
function global:au_GetLatest
{
	$html = Invoke-Webrequest -UseBasicParsing -Uri 'http://www.benf.org/other/cfr/' -Method Get
	$s = $html.RawContent
	$i = $s.IndexOf('href="cfr_') + 10
	$version = $s.Substring($i, 5)
	if ($s.Substring($i + 5, 4) -ne '.jar' -or !$version) { return }
	
	$url = "http://www.benf.org/other/cfr/cfr_${version}.jar"
	
	
	@{ URL32 = $url; Version = $version.Replace('_', '.'); ChecksumType32 = 'md5' }
}

update -ChecksumFor 32 -NoReadme -Force -NoCheckChocoVersion -NoCheckUrl -Verbose

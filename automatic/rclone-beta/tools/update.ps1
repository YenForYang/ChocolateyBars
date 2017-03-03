import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
#            "(^[$]url\s*=\s*)('.*')"       = "`$1'$($Latest.URL)'"
 #           "(^[$]checksum\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest
{
	$html = Invoke-Webrequest -Uri 'http://beta.rclone.org/'
	$url = 'http://beta.rclone.org/rclone-beta-latest-windows-386.zip'
	$url64 = 'http://beta.rclone.org/rclone-beta-latest-windows-amd64.zip'
	$version = $html.ParsedHtml.getElementsByTagName('A') | ?{ $_.outerHtml -match 'v.\...-.*' } | ?{ $_.innerText.length -eq ($html.ParsedHtml.getElementsByTagName('A') | ?{ $_.outerHtml -match 'v.\...-.*' } | %{ $_.innerText.length } | sort | select -last 1) } | % innerText | sort | select -last 1 | %{ $_ -replace '.{10}$' -replace '-', '.' -replace '^{1}.' }
	@{ URL = $url; URL64 = $url64; Version = $version }
}

update -NoCheckURl -ChecksumFor none

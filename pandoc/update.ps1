import-module au

$releases = 'https://github.com/jgm/pandoc/releases'

function global:au_SearchReplace() {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
			"(?i)(Get-RemoteChecksum).*"  = "`${1} $($Latest.URL64)"
			
			"(?i)(\s+x64:).*"			  = "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*"		  = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest() {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	
	$re32 = '/pandoc-(.+?)-windows-i386.msi'
	$re64 = '/pandoc-(.+?)-windows-x86_64.msi'
	$links = $download_page.links
	$url32 = $links | ? href -match $re32 | select -First 1 -expand href
	$url64 = $links | ? href -match $re64 | select -First 1 -expand href
    $version = $Matches[1] -replace '-.+$'
    @{
		URL32		  = 'https://github.com' + $url32
		URL64	 	= 'https://github.com' + $url64
        Version      = $version
        ReleaseNotes = "https://github.com/jgm/pandoc/releases/tag/${version}"
    }
}


update -ChecksumFor none -force

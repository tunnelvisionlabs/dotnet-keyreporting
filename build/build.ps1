param (
	# No parameters for this one yet...
)

$ErrorActionPreference = 'Stop'

# make sure the script was run from the expected path
$TargetsPath = ".\Rackspace.KeyReporting.targets"
if (!(Test-Path $TargetsPath)) {
	$host.ui.WriteErrorLine('The script was run from an invalid working directory.')
	exit 1
}

# download NuGet.exe if missing
$nuget = '..\.nuget\NuGet.exe'
if (-not (Test-Path $nuget)) {
	if (-not (Test-Path '..\.nuget')) {
		mkdir '..\.nuget'
	}

	$host.UI.WriteLine('Downloading NuGet executable...')
	Invoke-WebRequest 'https://nuget.org/nuget.exe' -OutFile $nuget
}

. .\version.ps1

if (-not (Test-Path 'nuget')) {
	mkdir "nuget"
}

&$nuget 'pack' 'Rackspace.KeyReporting.nuspec' '-OutputDirectory' 'nuget' '-Version' "$Version" '-NoDefaultExcludes'

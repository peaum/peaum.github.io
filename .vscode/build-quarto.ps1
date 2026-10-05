$ErrorActionPreference = "Stop"

$repositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$temporaryRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("peaum-quarto-" + [guid]::NewGuid().ToString("N"))
$temporaryQuarto = Join-Path $temporaryRoot "quarto"
$temporaryOutput = Join-Path $temporaryRoot "generated"
$publishedOutput = Join-Path $repositoryRoot "generated"
$locationPushed = $false

try {
	New-Item -ItemType Directory -Path $temporaryQuarto -Force | Out-Null
	Copy-Item -LiteralPath (Join-Path $repositoryRoot "_quarto.yml") -Destination $temporaryRoot
	Copy-Item -LiteralPath (Join-Path $repositoryRoot "quarto\quarto-content.css") -Destination $temporaryQuarto
	Copy-Item -LiteralPath (Join-Path $repositoryRoot "quarto\_includes") -Destination $temporaryQuarto -Recurse
	Copy-Item -LiteralPath (Join-Path $repositoryRoot "quarto\blog") -Destination $temporaryQuarto -Recurse
	Copy-Item -LiteralPath (Join-Path $repositoryRoot "quarto\projects") -Destination $temporaryQuarto -Recurse

	$quarto = Get-Command quarto -ErrorAction Stop
	Push-Location $temporaryRoot
	$locationPushed = $true
	& $quarto.Source render
	if ($LASTEXITCODE -ne 0) {
		throw "Quarto render failed with exit code $LASTEXITCODE."
	}
	Pop-Location
	$locationPushed = $false

	if (-not (Test-Path -LiteralPath $temporaryOutput)) {
		throw "Quarto completed without creating the generated output directory."
	}
	if (Test-Path -LiteralPath $publishedOutput) {
		Remove-Item -LiteralPath $publishedOutput -Recurse -Force
	}
	Move-Item -LiteralPath $temporaryOutput -Destination $publishedOutput
}
finally {
	if ($locationPushed) {
		Pop-Location
	}
	if (Test-Path -LiteralPath $temporaryRoot) {
		Remove-Item -LiteralPath $temporaryRoot -Recurse -Force
	}
}

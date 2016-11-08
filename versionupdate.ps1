$build = (Get-Content .\build.json | Out-String | ConvertFrom-Json)

$configFiles = Get-ChildItem . project.json -rec
$versionNumber = "$($build.version.major).$($build.version.minor).$env:BUILD_BUILDID"
Write-Host "Updating version number to $versionNumber"
foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -replace "0.0.0-INTERNAL", $versionNumber } |
    Set-Content $file.PSPath
}

param ([string] $GfmDroidProjectDir, [string] $BuildConfiguration, [string] $sourcesDirectory)
Write-Output "GfmDroidProjectDir: $GfmDroidProjectDir"
Write-Output "ConfigurationName: $BuildConfiguration"

$ManifestPath = $GfmDroidProjectDir + "/Properties/AndroidManifest.xml" 
Write-Host "ManifestPath: $ManifestPath"
[xml] $xdoc = Get-Content $ManifestPath
 
$package = $xdoc.manifest.package
$appName = $xdoc.manifest.application.label

Write-Host "package: $package" 
Write-Host "app name: $appName"


If ($BuildConfiguration -eq "HA_Dev" -and $package.EndsWith("droid"))
{
    $package = $package.Replace("droid", "dgmfdroid")
    $appName = $appName.Replace("$appName", "GE Dev")
}



If ($BuildConfiguration -eq "HA_Staging" -and $package.EndsWith("droid"))
{
    $package = $package.Replace("droid", "sgmfdroid")
    $appName = $appName.Replace("$appName", "GE Staging")
}
 

 
    $versionCode = $xdoc.manifest.versionCode
    Write-Host "versionCode: $versionCode" 
    [int] $iversion = ([convert]::ToInt32($versionCode, 10) + 1)
    Write-Host "versionCode after inc: $iversion"
    $xdoc.manifest.versionCode = [string] $iversion
    
$xdoc.manifest.package = $package
$xdoc.manifest.application.label = $appName
 
Remove-Item  -force -verbose $ManifestPath
  
 
$xdoc.Save($ManifestPath)
$appName = $xdoc.manifest.application.label

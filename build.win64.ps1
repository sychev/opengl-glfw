$mygame_directory = Split-Path -Path (Get-Location) -Leaf
$mygame_build_directory = "$mygame_directory-build.win64"
$clean = $false

astyle --options=.astylerc --recursive ./src/*.cpp,*.h

if ($clean) {
    Write-Output "Clean build: $mygame_build_directory will be deleted"
    Remove-Item -LiteralPath ..\$mygame_build_directory -Force -Recurse
}

cd ..\

 
If(!(test-path $mygame_build_directory))
{
    New-Item -ItemType Directory -Force -Path $mygame_build_directory
}

cd $mygame_build_directory
cmake ..\$mygame_directory -G "MinGW Makefiles"
cmake --build .

$steamDllDestination = ".\steam_api64.dll"
if(!(Test-Path $steamDllDestination)) {
    Copy-Item -Path "..\$mygame_directory\steamworks_sdk\redistributable_bin\win64\steam_api64.dll" -Destination $steamDllDestination
}
.\main.exe

cd ..\$mygame_directory

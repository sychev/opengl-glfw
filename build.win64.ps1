$mygame_directory = "mygame"
$mygame_build_directory = "mygame-build.win64"
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

# $glfwDllDestination = ".\glfw3.dll"
# if(!(Test-Path $glfwDllDestination)) {
#     Move-Item -Path "glfw-3.3.4\src\glfw3.dll" -Destination $glfwDllDestination
#     Move-Item -Path "reactphysics3d\libreactphysics3d.dll" -Destination $glfwDllDestination
# }
.\mygame.exe

cd ..\$mygame_directory

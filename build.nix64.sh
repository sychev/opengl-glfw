#!/usr/bin/env bash

mygame_directory="mygame"
mygame_build_directory="mygame-build.nix64"

clean=false

astyle --options=.astylerc --recursive ./src/*.cpp,*.h

if $clean
then
  echo "Rebuld from clean start"
  rm -rf ./$mygame_build_directory
else
  echo "Non-clean build (but it's faster)"
fi

cd ../
mkdir -p ./$mygame_build_directory
 
cd $mygame_build_directory
cmake ../$mygame_directory -G "Unix Makefiles"
cmake --build .
./mygame

cd ../$mygame_directory

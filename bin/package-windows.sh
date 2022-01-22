#!/bin/bash

if [ -z "$1" ]; then echo "\$1 is empty"; exit; fi

mkdir -p windows_package/$1/binaries
cp win/* windows_package/$1/binaries/
cp WinRing0x64.sys windows_package/$1/binaries/
cp config.json windows_package/$1/
cp cpuminer.bat windows_package/$1/
cp ../readme.txt windows_package/$1/
cp -r tune_presets_1.1.7 windows_package/$1/tune_presets_1.1.7

cd windows_package
7z a $1.zip .
mv $1.zip ../
cd ..
rm -frv windows_package/$1/

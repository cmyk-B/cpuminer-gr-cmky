#!/bin/bash

if [ -z "$1" ]; then echo "\$1 is empty"; exit; fi

mkdir -p linux_package/$1/binaries
cp unix/* linux_package/$1/binaries/
cp config.json linux_package/$1/
cp cpuminer.sh linux_package/$1/
cp ../readme.txt linux_package/$1/
cp -r tune_presets_1.1.7 linux_package/$1/tune_presets_1.1.7

tar -zcvf $1.tar.gz -C linux_package $1
rm -frv linux_package/$1/

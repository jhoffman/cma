#!/usr/bin/env sh

echo "Downloading Geodesic Flow Kernel Code"
curl -o GFK.zip 'http://www-scf.usc.edu/~boqinggo/domain_adaptation/GFK_v1.zip'
echo "Extracting Geodesic Flow Kernel Code"
unzip GFK.zip
rm GFK.zip
mv ToRelease_GFK GFK

echo "done."

#!/usr/bin/env sh

echo "Downloading IVT Code"
curl -o ivt.zip 'http://www.cs.toronto.edu/~dross/ivt/ivt-2008-05-04.zip'
echo "Extracting IVT Code"
unzip ivt.zip
rm ivt.zip

echo "done."

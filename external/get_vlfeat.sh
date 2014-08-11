#!/usr/bin/env sh

echo "Downloading vlfeat"
curl -o vlfeat.tar.gz 'http://www.vlfeat.org/download/vlfeat-0.9.18.tar.gz'
echo "Extracting vlfeat"
tar zxvf vlfeat.tar.gz
rm vlfeat.tar.gz
mv vlfeat-0.9.18 vlfeat
echo "done."

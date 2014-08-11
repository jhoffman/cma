#!/usr/bin/env sh

echo "Downloading Liblinear"
curl -o liblinear.tar.gz 'http://www.csie.ntu.edu.tw/~cjlin/liblinear/liblinear-1.94.tar.gz'
echo "Extracting Liblinear"
tar zxvf liblinear.tar.gz
rm liblinear.tar.gz
mv liblienar-1.94 liblinear
echo "Compile liblinear before using"

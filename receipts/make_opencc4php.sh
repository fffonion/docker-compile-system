#!/bin/bash
cd opencc4php-master
phpize
./configure
make -j4
make install

VERSION=$1
echo "OpenCC for PHP extension" > description-pak
checkinstall << EOF
n
2
opencc4php
3
$VERSION
4
$SUBVERSION
6
net
10
libopencc
11
opencc4php
EOF


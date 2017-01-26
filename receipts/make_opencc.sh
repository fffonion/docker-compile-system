#!/bin/bash
mv OpenCC-master opencc-master
cd opencc-master
make PREFIX=/usr
make install

VERSION=$1
echo "Open Chinese Convert
  OpenCC is an opensource project for conversion 
  between Traditional Chinese and Simplified Chinese, 
  supporting character-level conversion, phrase-level conversion,
  variant conversion and regional idioms among
  Mainland China, Taiwan and Hong kong." > description-pak
checkinstall << EOF
n
2
opencc
3
$VERSION
4
$SUBVERSION
6
net
10

11
opencc,libopencc
EOF


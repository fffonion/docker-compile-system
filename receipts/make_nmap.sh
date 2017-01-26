#!/bin/bash
cd nmap-*
./configure
make -j4
make install

VERSION=$1
echo "The Network Mapper
  Nmap is a utility for network exploration or security auditing. It
  supports ping scanning (determine which hosts are up), many port
  scanning techniques, version detection (determine service protocols
  and application versions listening behind ports), and TCP/IP
  fingerprinting (remote host OS or device identification). Nmap also
  offers flexible target and port specification, decoy/stealth scanning,
  sunRPC scanning, and more. Most Unix and Windows platforms are
  supported in both GUI and commandline modes. Several popular handheld
  devices are also supported, including the Sharp Zaurus and the iPAQ."> description-pak
checkinstall << EOF
n
2
nmap
3
$VERSION
4
$SUBVERSION
6
net
10
libssl1.0.2,libpcre3
11
nmap,ncat,nping,zenmap
EOF


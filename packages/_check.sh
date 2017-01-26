#!/bin/bash


function check_local
{
    d=$(cat "$1.sh"| grep VERSION| head -n1| grep -oP "[\d\-\._]+")
    if [[ ! -z $d && $d != $2 ]]; then
        echo "$1: upgrade from $d to $2"
        sed -i "s/VERSION=$d/VERSION=$2/" "$1.sh"
    fi
}

cd $(dirname $(readlink -f $0))

# aria2
v=$(curl -s https://aria2.github.io| grep -oP "https://github.com/aria2/aria2/releases/tag/release-[\d\.]+"| grep -oP "[\d\.]{2,}")
check_local aria2 $v

# openresty
v=$(curl -s http://openresty.org/en/download.html| grep -oP "openresty-[\d\.]+-win32.zip</a"| grep -oP "[\d\.]{4,}")
check_local openresty $v

# redis
v=$(curl -s https://redis.io/| grep -oP "Redis [\d\.]+ is the latest stable version"| grep -oP "[\d\.]+")
check_local redis $v

# shadowsock-libev
v=$(curl -s https://github.com/shadowsocks/shadowsocks-libev/releases| grep -oP "/shadowsocks/shadowsocks-libev/releases/tag/v[\d\.]+"| head -n1| grep -oP "[\d\.]+")
check_local shadowsocks $v

# opencc
v=$(curl -s https://github.com/BYVoid/OpenCC/releases| grep -oP "/BYVoid/OpenCC/releases/tag/ver.[\d\.]+"| head -n1| grep -oP "\d[\d\.]+")
check_local opencc $v

#nmap
v=$(curl -s https://nmap.org/download.html|grep -oP "nmap-[\d\.]+.tar.bz2"| head -n1| grep -oP "\d[\d\.]+\d")
check_local nmap $v

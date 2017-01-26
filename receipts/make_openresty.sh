#!/bin/bash
#cd ngx_openresty
#rm -rf ngx_openresty-*
#make
#rm *.tar.gz ../ngx_openresty-* -r
#mv ngx_openresty-* ../
#cd ..
#cd openresty-*/bundle/nginx-*/
#patch -p1 < ../../../nginx_upstream_check_module/check_1.9.2+.patch
#patch -p1 < ../../../nginx_tcp_proxy_module/tcp.patchdd
#patch -p1 < ../../../ngx_yoda.patch
#cd ../../

SCR=$(dirname $(readlink -f $0))
cd openresty-*
patch -p1 < $SCR/openresty/resty-dyn.patch
if [[ ! -z $2 && $2 == "-minimal" ]]; then
	./configure -j4 --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_realip_module  --with-http_gzip_static_module --with-threads --with-http_v2_module --with-file-aio  --with-stream \
	--with-http_geoip_module=dynamic\
	--without-http_ssi_module --without-http_userid_module --without-http_uwsgi_module --without-http_scgi_module --without-http_empty_gif_module --without-http_browser_module
else
	if [[ ! -z $2 && $2 == "-rtmp" ]]; then
		echo 123
	fi
	./configure -j4 --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_realip_module --with-http_addition_module  --with-http_gzip_static_module --with-threads --with-http_v2_module --with-http_sub_module  --with-file-aio  --with-stream --with-stream_ssl_module --with-http_stub_status_module  --with-http_dav_module \
	  --add-module=/build/nginx-modules/stream-lua-nginx-module --add-module=/build/nginx-modules/ngx_cache_purge \
	  --with-mail=dynamic  --with-http_geoip_module=dynamic --with-http_image_filter_module=dynamic --with-http_xslt_module=dynamic \
          --without-http_ssi_module --without-http_userid_module --without-http_uwsgi_module --without-http_scgi_module --without-http_empty_gif_module --without-http_browser_module \
	  --add-dynamic-module=/build/nginx-modules/nginx-unzip-module --add-dynamic-module=/build/nginx-modules/nginx-dav-ext-module --add-dynamic-module=/build/nginx-modules/nginx-rtmp-module --add-dynamic-module=/build/nginx-modules/nginx-module-vts $extra_mod \
	
	  # --add-dynamic-module=/build/ngx_pagespeed 
fi

#./configure -j4 --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_realip_module --with-http_addition_module  --with-http_gzip_static_module --with-threads --with-http_v2_module --with-http_sub_module  --with-file-aio  --with-stream --with-stream_ssl_module --with-http_stub_status_module  --with-http_dav_module

pushd build/nginx-*/objs
patch -p0 < $SCR/openresty/resty-install.patch
popd

make -j4
make install

rm -rf /usr/local/openresty
#rm /etc/nginx/{uwsgi_params,scgi_params,mime.types,fastcgi.conf}

for n in openresty-minimal openresty-rtmp; do
    if [[ ${n/$2/} == $n ]]; then
	replace_pkg=$replace_pkg,$n
    fi
done
if [[ ! -z $2 ]]; then
    replace_pkg=$replace_pkg",openresty"
fi

VERSION=$1
echo "OpenResty is a dynamic web platform based on NGINX and LuaJIT."> description-pak
checkinstall << EOF
n
2
openresty$2
3
$VERSION
4
$SUBVERSION
6
httpd
10
libssl1.0.2,libpcre3,libexpat1,libzip,openresty-common
11
openresty,resty,libluajit,nginx,nginx-common,nginx-extras
12
nginx-light
13
nginx,nginx-common,nginx-extras$replace_pkg
EOF


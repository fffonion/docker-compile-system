#cp ../php_mysqli_nonapi.patch ./
#patch -p1 < php_mysqli_nonapi.patch
SCR=$(dirname $(readlink -f $0))
cd php-*
patch -p1 < $SCR/php/php7_conf.patch
./configure --prefix=/usr --sysconfdir=/etc/php --with-config-file-scan-dir=/etc/php/fpm/conf.d --with-config-file-path=/etc/php/fpm --localstatedir=/var --mandir=/usr/share/man --disable-debug --disable-rpath \
     --disable-static \
      --with-layout=GNU --with-pear=/usr/share/php \
       --enable-mbstring --enable-zip --enable-bcmath --with-curl --with-gd --with-jpeg-dir=/usr --with-png-dir=/usr --with-zlib-dir=/usr --with-xpm-dir=/usr --with-freetype-dir=/usr --enable-gd-native-ttf --enable-gd-jis-conv --with-openssl --with-pdo-mysql --with-zlib --with-bz2 --with-mysqli=/usr/bin/mysql_config --enable-cgi --enable-fpm --with-libdir=lib/i386-linux-gnu --includedir=/usr/include/i386-linux-gnu \
	--with-mcrypt=shared --with-iconv=shared --with-gmp=shared --with-gettext=shared,/usr \
	--enable-shared=fileinfo,pcntl,calendar,posix,ftp,ctype
make -j4

VERSION=$1
echo "server-side, HTML-embedded scripting language (metapackage)
  This package is a metapackage that, when installed, guarantees that you
  have at least one of the four server-side versions of the PHP interpreter
  installed. Removing this package won't remove PHP from your system, however
  it may remove other packages that depend on this one.
  .
  PHP (recursive acronym for PHP: Hypertext Preprocessor) is a widely-used
  open source general-purpose scripting language that is especially suited
  for web development and can be embedded into HTML."> description-pak
checkinstall << EOF
n
2
php
3
$VERSION
4
$SUBVERSION
6
php
10
libmcrypt4,libgmp10,libcurl3,libmysqlclient20,libssl1.0.2
11
php,php-cli,php-config,php-fpm,php7.0-fpm,php7.0-common,php7.0-cli,php7.0-cgi
12
13
php7.0-fpm,php7.0-common,php7.0-cli,php7.0-cgi
EOF

	
	#--enable-ftp --enable-exif --with-calendar --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-fcntl
#--with-pic

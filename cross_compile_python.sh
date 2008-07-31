# http://whatschrisdoing.com/blog/2006/10/06/howto-cross-compile-python-25/

if [ ! -f Python2.5_xcompile.patch ]
then
wget http://whatschrisdoing.com/~lambacck/Python2.5_xcompile.patch
fi

if [ ! -f Python-2.5.tar.bz2 ]
then
wget http://www.python.org/ftp/python/2.5/Python-2.5.tar.bz2
fi
rm -rf Python-2.5
tar xjf Python-2.5.tar.bz2
cd Python-2.5
patch -p1 <../Python2.5_xcompile.patch

autoconf

export CC=gcc
export CXX=g++

./configure
make python Parser/pgen
mv python hostpython
mv Parser/pgen Parser/hostpgen
make distclean



export PATH=$DEVKITPPC/bin:$PATH
export CC=powerpc-gekko-gcc
export CXX=powerpc-gekko-g++
export MACHDEP=unknown

./configure --disable-shared --without-threads --disable-ipv6 --host=powerpc-gekko
make HOSTPYTHON=./hostpython HOSTPGEN=./Parser/hostpgen CROSS_COMPILE=yes

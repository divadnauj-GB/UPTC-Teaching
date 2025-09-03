#!/bin/sh

TARGET=$1
ARCH=$2
git clone https://git.code.sf.net/p/libpng/code libpng-code
cd libpng-code
git checkout libpng12
#./configure  --build=i686-linux-gnu CFLAGS=-m32 CPPFLAGS=-m32 LDFLAGS=-m32 
./configure  --build=x86_64-linux-gnu CFLAGS=-m64 CPPFLAGS=-m64 LDFLAGS=-m64 

make
cp -v .libs/*.a $TARGET
cp -v .libs/*.so* $TARGET
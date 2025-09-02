#!/bin/bash

echo \#include \<gelf.h\> > test.c
echo void main\(void\) \{\} >> test.c
INCFLAGS=
LDFLAGS=

ARCH=$(arch)
OS=$(uname)

if [ "$OS" = "Darwin" ]; then 
	INCFLAGS="-I/opt/homebrew/include -I/opt/homebrew/include/libelf"
	LDFLAGS="-L/opt/homebrew/lib"
fi

gcc ${INCFLAGS} ${LDFLAGS} test.c

if [ "$?" -ne "0" ]; then
  echo "Error: elf-loader requires the development version of libelf, which may be libelf-dev on your system. Make sure you have it installed."
  exit 1
fi

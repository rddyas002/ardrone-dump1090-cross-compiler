#!/bin/bash
set -eu

NODE_VERSION="v0.8.15"

echo "-> Installing apt-get packages"

sudo apt-get -y install \
  build-essential \
  curl \
  git \
  automake \
  libtool \
  pkg-config

echo "-> Downloading node.js source"

if [ ! -d node ]; then
  curl -O http://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz
  tar -zxf node-${NODE_VERSION}.tar.gz
  mv node-${NODE_VERSION} node
  rm -rf node-${NODE_VERSION}.tar.gz
fi

if [ ! -d rtl-sdr ]; then
    echo "-> Downloading rtl-sdr source."
    git clone git://git.osmocom.org/rtl-sdr.git
fi

if [ ! -d libusb-1.0.9 ]; then
    echo "-> Downloading libusb source."
    curl -L -O http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-1.0.9/libusb-1.0.9.tar.bz2
    tar xvj libusb-1.0.9.tar.bz2
fi

if [ ! -d dump1090 ]; then
    echo "-> Downloading dump1090 source."
    git clone git://github.com/wiseman/dump1090.git
fi


# Unfortunately we can't put this into our project dir as vboxfs complains
# about hardlinks in the tar : /
echo "-> Installing code sourcer (arm toolchain)"
if [ ! -d ~/armtools ]; then
  cd ~
  tarball="arm-2012.03-57-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2"
  curl -OL http://www.codesourcery.com/public/gnu_toolchain/arm-none-linux-gnueabi/${tarball}
  tar -xf ${tarball}
  mv arm-2012.03 armtools
  rm -rf ${tarball}
fi

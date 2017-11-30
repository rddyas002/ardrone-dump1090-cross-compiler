#!/bin/bash
set -eu

echo "-> apt-get installing packages"

sudo apt-get -y install \
    automake \
    build-essential \
    curl \
    git \
    libtool \
    pkg-config

mkdir -p src

if [ ! -d src/libusb-1.0.9 ]; then
    echo "-> Downloading libusb source."
    (cd src &&
        curl -L -O "http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-1.0.9/libusb-1.0.9.tar.bz2" &&
        tar xvjf libusb-1.0.9.tar.bz2)
fi

if [ ! -d src/rtl-sdr ]; then
    echo "-> Downloading rtl-sdr source."
    (cd src &&
        git clone git://git.osmocom.org/rtl-sdr.git)
fi

# Unfortunately we can't put this into our project dir as vboxfs complains
# about hardlinks in the tar : /
if [ ! -d ~/armtools ]; then
    echo "-> Installing code sourcer (arm toolchain)"
    cd ~
    tarball="arm-2012.03-57-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2"
    curl -OL https://sourcery.mentor.com/public/gnu_toolchain/arm-none-linux-gnueabi/${tarball}
    tar -xf ${tarball}
    mv arm-2012.03 armtools
    rm -rf ${tarball}
fi

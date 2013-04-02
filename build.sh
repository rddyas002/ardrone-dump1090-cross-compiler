#!/bin/bash
set -e
set -x

export SOURCERY="`cd ../armtools && pwd`"
export TOOL_PREFIX="${SOURCERY}/bin/arm-none-linux-gnueabi"
export CXX="${TOOL_PREFIX}-g++"
export AR="${TOOL_PREFIX}-ar"
export RANLIB="${TOOL_PREFIX}-ranlib"
export CC="${TOOL_PREFIX}-gcc"
export LINK="${CXX}"
export CCFLAGS="-march=armv7-a -mtune=cortex-a8 -mfpu=vfp"
export ARM_TARGET_LIB="${SOURCERY}/arm-none-linux-gnueabi/libc"

export PREFIX_DIR="/home/vagrant/cross-compiler/sysroot"
export PKG_CONFIG_PATH="/home/vagrant/cross-compiler/sysroot/lib/pkgconfig"

(cd src/libusb-1.0.9 &&
 ./configure --host=arm-linux --prefix=${PREFIX_DIR} && make install --jobs=16)

(cd src/rtl-sdr &&
 autoreconf -i &&
 ./configure --host=arm-linux --prefix=${PREFIX_DIR} &&
 make install --jobs=16)

(cd src/dump1090 && make --jobs=16)

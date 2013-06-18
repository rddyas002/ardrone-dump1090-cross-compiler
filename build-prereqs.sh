#!/bin/bash
set -e
set -x

. $(dirname $0)/build-vars.sh

(cd src/libusb-1.0.9 &&
 ./configure --host=arm-linux --prefix=${PREFIX_DIR} && make install --jobs=16)

(cd src/rtl-sdr &&
 autoreconf -i &&
 ./configure --host=arm-linux --prefix=${PREFIX_DIR} &&
 make install --jobs=16)

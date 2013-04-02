#!/bin/bash
set -eu

BASEDIR=$(dirname $0)/..

if [ ! -e build/bin/node ]; then
  echo "-> Spinning up VM"
  vagrant up
  echo "-> Building dump1090 binary"
  vagrant ssh -c "cd cross-compiler && ./build.sh"
else
  echo "-> Skipping build (dump1090 binary exists)"
fi

echo "Would you like to install node on the drone? (Connect now) [Y/n]"
read a
if [[ $a == "Y" || $a == "y" || $a = "" ]]; then
  echo "-> Uploading binary"
  ftp -u ftp://anonymous:anonymous@192.168.1.1/librtlsdr.so.0.0.0 ${BASEDIR}/sysroot/lib/librtlsdr.so.0.0.0
  ftp -u ftp://anonymous:anonymous@192.168.1.1/rtl_sdr ${BASEDIR}/sysroot/bin/rtl_sdr
  ftp -u ftp://anonymous:anonymous@192.168.1.1/dump1090 ${BASEDIR}/src/dump1090/dump1090
  echo "-> Installing"
  { echo "cd /data/video && chmod +x dump1090 rtl_sdr && mv rtl_sdr dump1090 /bin && mv librtlsdr.so.0.0.0 /lib && cd /lib && ln -s librtlsdr.so.0.0.0 librtlsdr.so.0 && exit"; sleep 2; } | telnet 192.168.1.1
  echo "-> Installation completed!"
else
  echo "-> Build completed!"
fi

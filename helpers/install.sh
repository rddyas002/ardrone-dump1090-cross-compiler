#!/bin/bash
set -eu

BASEDIR=$(dirname $0)/..

echo "-> Uploading binary"
ftp -u ftp://anonymous:anonymous@192.168.1.1/librtlsdr.so.0.0.5 ${BASEDIR}/sysroot/lib/librtlsdr.so.0.0.5
ftp -u ftp://anonymous:anonymous@192.168.1.1/rtl_sdr ${BASEDIR}/sysroot/bin/rtl_sdr
ftp -u ftp://anonymous:anonymous@192.168.1.1/dump1090 ${BASEDIR}/src/dump1090/dump1090
echo "-> Installing"
{ echo "cd /data/video && chmod +x dump1090 rtl_sdr && mv rtl_sdr dump1090 /bin && mv librtlsdr.so.0.0.5 /lib && cd /lib && ln -s librtlsdr.so.0.0.5 librtlsdr.so.0 && exit"; sleep 2; } | telnet 192.168.1.1
echo "-> Installation completed!"

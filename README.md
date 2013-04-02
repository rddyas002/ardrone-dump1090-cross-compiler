# ardrone-dump1090-cross-compiler

This project makes it easy to cross-compile
[rtl-sdr](http://sdr.osmocom.org/trac/wiki/rtl-sdr) and the
[dump1090](https://github.com/antirez/dump1090) Mode S decoder for the
AR.Drone 2.

## Requirements

You will need to install [vagrant](http://vagrantup.com/) as the cross
compiling is done inside of a virtual machine.

## Cross compiling

Cross compiling rtl-sdr and dump1090 for the AR.Drone 2 is as easy as
running the following:

```bash
$ git clone git://github.com/wiseman/ardrone-dump1090-cross-compiler.git
$ cd dump1090-ardrone-cross-compiler
$ vagrant up
$ vagrant ssh
$ cd cross-compiler
$ ./setup-vm.sh
$ ./build.sh
```

This will fire up a new vagrant machine, ssh into it, and build
rtl-sdr and dump1090 to run on the AR.Drone 2.

## Installation

A helper script will install rtl-sdr and dump1090 on your AR.Drone 2.
First connect to the drone's wifi.  Then run the following (on your host OS, not in the vagrant VM):

```bash
$ ./helpers/install.sh
```

## Usage

Before plugging your RTL-SDR dongle into your AR.Drone, you will need
to run these commands to activate USB host mode:

```
$ telnet 192.168.1.1
# gpio 127 -d ho 1
# gpio 127 -d i
```

Now you can plug your RTL-SDR dongle into the drone's USB connector.
Once that's done you can make sure the dongle is visible by running
`lsusb`:

```
# lsusb
Bus 001 Device 002: ID 0bda:2838 Realtek Semiconductor Corp. 
Bus 001 Device 001: ID 1d6b:0002  
```

If you don't see your dongle (mine is the Realtek device listed
above), try unplugging and re-plugging the dongle.

You may now run `dump1090`:

```
# dump1090 --interactive

Hex    Flight   Altitude  Speed   Lat       Lon       Track  Messages Seen   .
--------------------------------------------------------------------------------
a54601          0         0       0.000     0.000     0     1         0 sec
a73f0b          2475      0       0.000     0.000     0     2         1 sec
aa6e4f          33000     0       0.000     0.000     0     26        0 sec
a2597f          40000     0       0.000     0.000     0     7         2 sec
a71d34          33275     0       0.000     0.000     0     14        0 sec
71be10 KAL213   4875      272     34.029    -118.312   85    166       0 sec
```

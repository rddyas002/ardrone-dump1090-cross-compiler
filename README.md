# ardrone-dump1090-cross-compiler

John Wiseman, jjwiseman@gmail.com

This project makes it easy to use a cheap and widely available
[DVB-T](http://en.wikipedia.org/wiki/DVB-T) USB dongle as a
software-defined radio on your AR.Drone 2.  Your drone will then be
able to pick up Mode S and
[ADS-B](http://en.wikipedia.org/wiki/Automatic_dependent_surveillance-broadcast)
broadcasts from aircraft transponders (see the [rtl-sdr
project](http://sdr.osmocom.org/trac/wiki/rtl-sdr) and "[Tracking
planes for $20 or
less](http://www.irrational.net/2012/08/06/tracking-planes-for-20-or-less)"
for background).

What the project actually provides is an easy way to cross-compile the
[dump1090](https://github.com/antirez/dump1090) Mode S decoder for the
AR.Drone.

## Requirements

You will need to install [vagrant](http://vagrantup.com/) as the
cross-compiling is done inside of a virtual machine.

## Cross compiling

Cross compiling rtl-sdr and dump1090 for the AR.Drone 2 is as easy as
running the following:

```bash
$ git clone git://github.com/wiseman/ardrone-dump1090-cross-compiler.git
$ cd ardrone-dump1090-cross-compiler
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
First connect to the drone's wifi.  Then run the following (on your
host OS, not in the vagrant VM):

```bash
$ ./helpers/install.sh
```

The install script puts `rtl_sdr` and `dump1090` in `/bin`, and
`librtlsdr.so.0.0.0` in `/lib`.

## Usage

Before plugging your DVB-T dongle into your AR.Drone, you will need to
run these commands to activate USB host mode:

```
$ telnet 192.168.1.1
# gpio 127 -d ho 1
# gpio 127 -d i
```

Now you can plug the dongle into the drone's USB connector.  Once
that's done you can confirm that the dongle is visible by running
`lsusb`:

```
# lsusb
Bus 001 Device 002: ID 0bda:2838 Realtek Semiconductor Corp. 
Bus 001 Device 001: ID 1d6b:0002  
```

If you don't see your dongle (the Realtek device listed above), try
unplugging and re-plugging it.

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

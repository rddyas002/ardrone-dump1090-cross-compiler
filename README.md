# dump1090-cross-compiler

This project makes it easy to cross-compile rtl-sdr and the dump1090
Mode S decoder for the AR.Drone.

## Requirements

You will need to install [vagrant](http://vagrantup.com/) as the cross
compiling is done inside of a virtual machine.

## Cross compiling

Cross compiling rtl-sdr and dump1090 for the AR.Drone is as easy as
running:

```bash
$ git clone git://github.com/wiseman/dump1090-ardrone.git
$ cd dump1090-ardrone
$ vagrant up
$ vagrant ssh
$ cd cross-compiler
$ ./setup-vm.sh
$ make ardrone2
```

This will fire up a new vagrant machine, ssh into it, and build node.js to run
on the ardrone2. You will find the resulting binary in `build/bin/node`.

## Platforms

### ardrone2

Helpers have been added for installing node on the ardrone. Simply running ```./helpers/ardrone2.sh``` will build and install node on your drone.

## Contributing

If you want to contribute support for another platform, we probably need a
`common.sh` file for shared environment variables. Other than that it should
be as simple as adding it to the `platforms` folder and `Makefile`.

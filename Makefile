ardrone2:
	./platforms/ardrone2.sh

librtlsdr:
	./platforms/librtlsdr.sh

clean:
	cd node && git clean -fdX
	rm -rf build

.PHONY: ardrone2 clean

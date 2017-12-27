#! /bin/sh

echo makeします.
make
sudo insmod myled.ko
sudo chmod 666 /dev/myled0

echo LEDの点滅を開始します.
while :
do
	echo 1 > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0

	echo 2 > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0

	echo 3 > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0

	echo 4 > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0

	echo 5 > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0

	echo 6 > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0

	echo 7 > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0

	echo 8 > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0
	
	trap 'echo 終了します. ; echo 0 > /dev/myled0 ; sudo rmmod myled ; exit 1' 1 2 3 15
done

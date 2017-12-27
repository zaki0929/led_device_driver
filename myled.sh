#! /bin/sh

echo makeします.
make
sudo insmod myled.ko
sudo chmod 666 /dev/myled0

echo LEDの点滅を開始します.
while :
do
	echo 1 > /dev/myled0
	sleep 1s
	echo 0 > /dev/myled0
	sleep 1s
	echo 2 > /dev/myled0
	sleep 1s
	echo 0 > /dev/myled0
	sleep 1s
	echo 3 > /dev/myled0
	sleep 1s
	echo 0 > /dev/myled0
	sleep 1s
	
	trap 'echo 終了します. ; sudo rmmod myled ; exit 1' 1 2 3 15
done

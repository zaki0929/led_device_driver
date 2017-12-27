#! /bin/sh

echo makeします.
make
sudo insmod myled.ko
sudo chmod 666 /dev/myled0

echo LEDの点滅を開始します.
LED_COUNT=8
i=0
while :
do
	if [ $i -gt $LED_COUNT ] ; then
		i=1
	else
		i=$(( i + 1 ))
	fi

	echo $i > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0
	
	trap 'echo 終了します. ; echo 0 > /dev/myled0 ; sudo rmmod myled ; exit 1' 1 2 3 15
done

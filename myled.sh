#! /bin/sh

echo makeします.
make
sudo insmod myled.ko
sudo chmod 666 /dev/myled0

echo LEDの点滅を開始します.

sudo echo 23 > /sys/class/gpio/export
sudo echo 24 > /sys/class/gpio/export

sudo echo in > /sys/class/gpio/gpio23/direction
sudo echo in > /sys/class/gpio/gpio24/direction

sudo echo high > /sys/class/gpio/gpio23/direction
sudo echo high > /sys/class/gpio/gpio24/direction

LED_COUNT=8
i=1
while :
do
	SW1=$(cat /sys/class/gpio/gpio23/value)
	SW2=$(cat /sys/class/gpio/gpio24/value)

	if [ $i -gt $LED_COUNT ] ; then
		i=1
	elif [ $i -lt 0 ] ; then
		i=8
	elif [ $SW2 = 0 ] ; then
		i=$(( i + 1 ))
	elif [ $SW1 = 0 ] ; then
		i=$(( i - 1 ))
	fi

	echo $i > /dev/myled0
	sleep 0.1s
	echo 0 > /dev/myled0
	
	trap 'echo 終了します. ; echo 0 > /dev/myled0 ; sudo rmmod myled ; echo 23 > /sys/class/gpio/unexport ; echo 24 > /sys/class/gpio/unexport ; exit 1' 1 2 3 15
done

#! /bin/sh

GPIO_SYSFS_DIR=/sys/class/gpio
gpio=$1
val=$2

GPIO_DIR=$GPIO_SYSFS_DIR/gpio$gpio
if [ ! -e $GPIO_DIR ]
then
	echo $gpio > $GPIO_SYSFS_DIR/export
fi
echo out > $GPIO_DIR/direction
echo $val > $GPIO_DIR/value

#!/bin/sh

echo -n "What is your default gateway to Internet? "
read GATEWAY
route del default
route add default gw $GATEWAY netmask 0.0.0.0

echo "route del default"
echo "route add default gw $GATEWAY netmask 0.0.0.0"

echo -n "Do you need to edit resolv.conf for DNS lookup? [y/n] "
read ANS
if [ $ANS = "y" ]
then
    vi /etc/resolv.conf
fi


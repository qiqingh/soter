#!/bin/sh

usage()
# Check argument number
if [ $# -ne 3 ]
then
    usage;
fi

WANIF=$1
LANIP=$2
LANMASK=$3

iptables -t nat -F
iptables -t nat -A POSTROUTING -o $WANIF -s $LANIP/$LANMASK -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward

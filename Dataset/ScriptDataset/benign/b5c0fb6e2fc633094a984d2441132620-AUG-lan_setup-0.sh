#!/bin/sh

ifconfig eth0 up
brctl addbr br0
brctl addif br0 eth0
brctl stp br0 1
ifconfig br0 192.168.1.1 netmask 255.255.255.0 up

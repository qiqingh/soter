#!/bin/sh

ifconfig eth1 10.128.32.221 netmask 255.255.255.0 up

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -t nat -I POSTROUTING -o eth1 -j MASQUERADE

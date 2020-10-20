#!/bin/sh
WAN=eth0
echo "Input IP range for MASQUERADE (PC's ip range which use this linux machine as a router"
echo -n "LAN port IP: "
read LAN_IP
echo -n "LAN port Netmask (in format 255.255.255.0 or 24): "
read LAN_NETMASK

iptables -t nat -F
iptables -t nat -A POSTROUTING -o ${WAN} -s $LAN_IP/$LAN_NETMASK -j MASQUERADE
#iptables -t nat -A PREROUTING -m tcp -p tcp -d ! $LAN_IP --dport 80 -j REDIRECT --to-ports 10080
echo 1 > /proc/sys/net/ipv4/ip_forward

echo "iptables -t nat -F"
echo "iptables -t nat -A POSTROUTING -o ${WAN} -s $LAN_IP/$LAN_NETMASK -j MASQUERADE"
#echo "iptables -t nat -A PREROUTING -m tcp -p tcp -d ! $LAN_IP --dport 80 -j REDIRECT --to-ports 10080"
echo "echo 1 > /proc/sys/net/ipv4/ip_forward"

#!/bin/sh
#
# script file to setup  network
#
#

Kill useless proc
PROC_LIST="iapp wscd iwcontrol dnrd udhcpc syslogd klogd mpserver dcc wkeeper reload llmnr zcip UDPserver lld2d"
for proc in $PROC_LIST ; do
	killall $proc
done


#GETMIB="flash gethw"
#ELAN_MAC_ADDR="000000000000"
#eval `$GETMIB HW_NIC0_ADDR`
#if [ "$HW_NIC0_ADDR" = "000000000000" ]; then
      #  eval `$GETMIB HW_NIC0_ADDR`
        ELAN_MAC_ADDR="56aaa55a7de8"
#else
#	ELAN_MAC_ADDR=$HW_NIC0_ADDR
#fi
ifconfig br0:0 down
ifconfig br0:1 down
ifconfig lo   127.0.0.1
#ifconfig eth0 hw ether $ELAN_MAC_ADDR
#ifconfig eth1 hw ether $ELAN_MAC_ADDR
#brctl addbr br0
#brctl addif br0 eth0
#brctl addif br0 eth1

ifconfig wlan0 down
ifconfig br0 192.168.0.50

iwpriv wlan0 set_mib mp_specific=1
ifconfig  wlan0 up
ifconfig  eth0 up
ifconfig  eth1 up

echo O > /proc/gpio
# For MP F1
UDPserver &

echo E > /proc/gpio
echo W > /proc/gpio
echo s > /proc/gpio
echo L > /proc/gpio

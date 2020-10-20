#!/bin/sh
echo "Restart hostapd for schedule" > /dev/console
killall hostapd > /dev/null 2>&1
sleep 1
xmldbc -P /etc/services/WIFI/hostapdcfg_sch.php > /var/topology.conf
hostapd /var/topology.conf &

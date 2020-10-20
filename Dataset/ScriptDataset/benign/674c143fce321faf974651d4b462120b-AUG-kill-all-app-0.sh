#!/bin/sh
# This script will be exec when entering downloading mode.
KILLALL=/usr/bin/killall
IP_X=/usr/sbin/iptables
RMMOD=/sbin/rmmod
/bin/echo "hnat disable" > /proc/star9100_shnat_setting
$KILLALL bpamonitor 2>/dev/null
$KILLALL monitor 2>/dev/null
$KILLALL udhcpd 2>/dev/null
$KILLALL syslogd 2>/dev/null
$KILLALL crond 2>/dev/null
$KILLALL udhcpc 2>/dev/null
$KILLALL klogd 2>/dev/null
$KILLALL pppd 2>/dev/null
$KILLALL pppd 2>/dev/null
$KILLALL ntp 2>/dev/null
$KILLALL routed 2>/dev/null
$KILLALL reaim 2>/dev/null
$KILLALL zebra 2>/dev/null
$KILLALL ripd 2>/dev/null
$KILLALL upnpd 2>/dev/null
$KILLALL pb_ap 2>/dev/null
$KILLALL ssl_server 2>/dev/null
$KILLALL pluto 2>/dev/null
$KILLALL wizd 2>/dev/null
$KILLALL switch_app 2>/dev/null
$KILLALL radvd 2>/dev/null
$KILLALL nat-pt 2>/dev/null
$KILLALL -9 stunnel 2>/dev/null
$RMMOD push_button


$IP_X -P INPUT ACCEPT
$IP_X -F
$IP_X -X
$IP_X -t nat -F
$IP_X -t nat -X
if [ "$1" = "utility" ] ; then
    $KILLALL cmd_agent_ap 2>/dev/null
    $KILLALL scfgmgr 2>/dev/null
    $KILLALL -9 mini_httpd 2>/dev/null
else
    $KILLALL download 2>/dev/null
fi

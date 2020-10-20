#!/bin/sh

LED_NET_ORANGE=13
LED_NET_BLUE=15
LED_WPS=5
LED_PWR=10

INTERNETREADY="0"
INTERNETFAIL="1"

LEDSTATUSPATH="/tmp/ledstatus"

OLDSTATUS=`cat $LEDSTATUSPATH`

action=$1
case "$action" in
    system_ready)
            system_ready ;;
    system_booting)
            system_booting ;;
    wps_start)
            wps_start ;;
    wps_fail)
            wps_fail ;;
    wps_finish)
            wps_finish ;;
    internet_ready)
            no_internet_connect ;;
    *)
            usage ;;
esac


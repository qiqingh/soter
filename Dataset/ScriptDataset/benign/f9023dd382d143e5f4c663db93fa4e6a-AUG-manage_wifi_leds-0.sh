#!/bin/sh
#
# Manages WiFi LEDs
#
# $1 - link_status_changed
# $2 - something like:
#      connected,925F6468-CC3E-468B-B31A-D982FF75B27A,00:25:9C:13:06:51,wdev0ap0,WiFi,90:18:7C:A0:9E:CA,2.4G,mixed,100dbm
#

WIFI24G=wdev0ap0
WIFI5G=wdev1ap0

LED_CTRL=/proc/bdutil/leds

if [ ! -e $LED_CTRL ]
then
    exit 0
fi

wifi=`echo "$2" | awk -F ',' '{ print $4 }'`

case "$wifi" in
    $WIFI24G)
        iwpriv $WIFI24G getstalistext | grep -q ASSOCIATED
        if [ "$?" == "0" ]; then
            echo "24g=on" > $LED_CTRL
        else
            echo "24g=off" > $LED_CTRL
        fi
        ;;

    $WIFI5G)
        iwpriv $WIFI5G getstalistext | grep -q ASSOCIATED
        if [ "$?" == "0" ]; then
            echo "5g=on" > $LED_CTRL
        else
            echo "5g=off" > $LED_CTRL
        fi
        ;;
esac
        

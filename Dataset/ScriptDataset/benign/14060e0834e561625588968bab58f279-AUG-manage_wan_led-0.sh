#!/bin/sh
#
#------------------------------------------------------------------
# © 2013 Belkin International, Inc. and/or its affiliates. All rights reserved.
#------------------------------------------------------------------
#
# Manages WAN LED
#
# normal wan is white
# alternate wan is amber, i.e. altblink means amber blink
#
# If link is down, flash amber (physical connection problem)
# If link is up, but no protocol connectivity, flash white (establishing link)
# if link is up and protocol is up, solid white
#
# If Belkin ICC (Internet Connection Checking) is disabled, the as long as the
# WAN proto is up, then it will be solid white
#

WL1_STATUS=`syscfg get wl1_state`
WL0_STATUS=`syscfg get wl0_state`

if [ "down" = "${WL1_STATUS}" ] && [ "down" = "${WL0_STATUS}" ]; then
	exit 0
fi

bridge_mode=`syscfg get bridge_mode`
if [ $bridge_mode == "0" ]; then
    # ------------------------------------------------------------------------
    # Router mode 
    # - ICC is running
    # - phylink_wan_state indicates WAN physical Ethernet link
    # - wan_status indicates protocol up
    # - icc_internet_state indicates internet connectivity
    # ------------------------------------------------------------------------
    link=`sysevent get phylink_wan_state`
    if [ "$link" == "down" ]
    then
        # link down blink at 0.7HZ
        echo "internet_error" > /proc/bdutil/leds
        exit 0
    fi

    wan_status=`sysevent get wan-status`
    if [ "$wan_status" != "started" ]
    then
        # link up but protocol down
        echo "internet_error" > /proc/bdutil/leds
        exit 0
    fi

    # link up, protocol up, and internet up/no internet checking
	echo "internet_normal" > /proc/bdutil/leds
fi


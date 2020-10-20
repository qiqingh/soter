#!/bin/sh
echo [$0] ... > /dev/console
APMODE=`rgdb -g /wlan/inf:1/ap_mode`
CONNECT=`rgdb -i -g /runtime/stats/wlan/inf:1/client:1/mac`
if [ "$APMODE" = "2" ]; then
wlanconfig ath1 list scan
elif [ "$APMODE" = "1" ]; then
	if [ -z "$CONNECT" ]; then
	wlanconfig ath0 list scan
	else
	iwlist ath0 scanning
	wlanconfig ath0 list scan
	fi
else 
iwlist ath0 scanning
fi

#!/bin/sh
echo [$0] ... > /dev/console
if [ $1 = "g" ]; then
APMODE=`rgdb -g /wlan/inf:1/ap_mode`
CONNECT=`rgdb -i -g /runtime/stats/wlan/inf:1/client:1/mac`
ATH_DEV="ath0"
APR_DEV="ath1"
INSTRUCTION=`rgdb -g /wlan/inf:1/instruction`

else
APMODE=`rgdb -g /wlan/inf:2/ap_mode`
CONNECT=`rgdb -i -g /runtime/stats/wlan/inf:2/client:1/mac`
ATH_DEV="ath16"
APR_DEV="ath17"
INSTRUCTION=`rgdb -g /wlan/inf:2/instruction`

fi

if [ "$APMODE" = "2" ]; then
wlanconfig $APR_DEV list scan
elif [ "$APMODE" = "1" ]; then
	if [ -z "$CONNECT" ]; then
		if [ "$INSTRUCTION" = "1" ]; then
                        iwlist $ATH_DEV scanning
                else
			wlanconfig $ATH_DEV list scan
		fi
	else
	iwlist $ATH_DEV scanning
	fi
else 
iwlist $ATH_DEV scanning
fi

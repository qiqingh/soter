#!/bin/sh
echo [$0] ... > /dev/console
#rgdb -i -d /runtime/wireless/wdslistinfo
if [ $1 = "g" ]; then
iwpriv ath0 wdssite 1
iwlist ath0 scanning
else
iwpriv ath16 wdssite 1
iwlist ath16 scanning
fi

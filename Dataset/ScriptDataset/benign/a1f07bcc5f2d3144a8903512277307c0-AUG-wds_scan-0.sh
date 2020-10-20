#!/bin/sh
echo [$0] ... > /dev/console
#rgdb -i -d /runtime/wireless/wdslistinfo
iwpriv ath0 wdssite 1
iwlist ath0 scanning


#!/bin/sh

		
ddns_enable=`nvram_get 2860 ddns_enable`
if [ "$ddns_enable" == "5" ]; then
	/sbin/noip.sh
fi

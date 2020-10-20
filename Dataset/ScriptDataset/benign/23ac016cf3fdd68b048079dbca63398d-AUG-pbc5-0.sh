#!/bin/sh
#
# PBC5 startup script
#
#


#back to ap/repeater mode
RPT_ENABLED=`flash get REPEATER_ENABLED1 | cut -f2 -d=`

	flash set MODE 1
if [ $RPT_ENABLED = '1' ]; then
	flash set WLAN0_VAP4_WLAN_DISABLED 0
#kill wlan0-vxd wscd.
#	kill `cat /var/run/wscd-wlan0-vxd.pid`
else
	#reconfig wlan to client modeflash set MODE 1
	flash set WLAN0_WSC_UPNP_ENABLED 0
	sysconf init ap wlan_app
	flash set MODE 0
fi
flash set WLAN0_WSC_UPNP_ENABLED 1

#triger pbc
wscd -sig_pbc wlan0

# Bye Message
echo "Good Luck!!"

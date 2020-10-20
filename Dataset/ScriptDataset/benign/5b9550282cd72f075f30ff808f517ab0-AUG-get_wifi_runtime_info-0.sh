#!/bin/sh
source /etc/init.d/service_wifi/wifi_utils.sh
sleep 3
for INTF in $PHYSICAL_IF_LIST
do
	VIR_IFNAME=`get_syscfg_interface_name $INTF`
	CHANNEL=`wl -i $INTF status | grep -rin "Control Channel" | awk -F":" '{print $3}'`
	if [ -z "$CHANNEL" ]; then
	        CURRENT_CH=`wl -i $INTF chanspec | awk -F" " '{print $1}'`
    	        if [ `echo "$CURRENT_CH" | grep "l"` ]; then
		    CURRENT_CH=`echo $CURRENT_CH | awk -F"l" '{print $1}'`
                elif [ `echo "$CURRENT_CH" | grep "u"` ]; then
		    CURRENT_CH=`echo $CURRENT_CH | awk -F"u" '{print $1}'`
    	        elif [ `echo "$CURRENT_CH" | grep "/"` ]; then
		    CURRENT_CH=`echo $CURRENT_CH | awk -F"/" '{print $1}'`
                fi
	else
		CURRENT_CH=$CHANNEL
		if [ "wl0" = "$VIR_IFNAME" ]; then
			if [ `expr $CHANNEL` -lt 1 ] || [ `expr $CHANNEL` -gt 14 ]; then
				CURRENT_CH=0 
			fi
		else
			if [ `expr $CHANNEL` -lt 36 ] || [ `expr $CHANNEL` -gt 165 ]; then
				CURRENT_CH=0 
			fi
		fi
	fi
	sysevent set "$VIR_IFNAME"_channel "$CURRENT_CH"
done
exit

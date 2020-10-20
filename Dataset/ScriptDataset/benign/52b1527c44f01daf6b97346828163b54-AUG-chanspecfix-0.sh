#!/bin/sh
source /etc/init.d/interface_functions.sh
source /etc/init.d/service_wifi/wifi_utils.sh
WIFI_DEBUG_SETTING=`syscfg get chanspec_debug`
init()
while [ 1 ]; do
	for ifs in $PHYSICAL_IF_LIST; do
		VIR_IFNAME=`get_syscfg_interface_name $ifs`
		eval channel_status="\$channel_$VIR_IFNAME"	
		wl_state=`syscfg get ${VIR_IFNAME}_state`
		if [ "down" = "$wl_state" ] || [ "1" = "$channel_status" ]; then
			eval channel_$VIR_IFNAME="1"
			continue
		fi
		if [ "started" != "`sysevent get wifi-status`" ]; then
			continue
		fi
		CONF_CHANNEL=`syscfg get ${VIR_IFNAME}_channel`
		if [ "0" = "$CONF_CHANNEL" ]; then
			eval channel_$VIR_IFNAME="1"
		else
			CHANNEL_SIDEBAND=`wl -i $ifs chanspec | awk -F" " '{print $1}'`	
			BANDWIDTH=`get_vendor_bandwidth $VIR_IFNAME`
			CHANSPEC=$CONF_CHANNEL
			if [ "20" = "$BANDWIDTH" ]; then
				CHANSPEC=$CONF_CHANNEL
			elif [ "40" = "$BANDWIDTH" ]; then
				ic=`expr $CONF_CHANNEL`
				if [ "wl0" = "$VIR_IFNAME" ]; then
					REGION_CODE=`syscfg get device::ccode`
					MIX_CHANNAEL=7
					if [ "EU" = "$REGION_CODE" ]; then
						MIX_CHANNAEL=9
					fi	
		
					if [ $ic -lt 5 ]; then
						SIDEBAND="l"
					elif [ $ic -gt $MIX_CHANNAEL ]; then
						SIDEBAND="u"
					elif [ $ic -ge 5 ] || [ $ic -le $MIX_CHANNAEL ]; then
						sideband=`syscfg get ${VIR_IFNAME}_sideband`
						SIDEBAND="u"
						if [ "lower" = "$sideband" ]; then
							SIDEBAND="l"
						fi
					fi    			
				else
					if [ 36 = $ic -o 44 = $ic -o 52 = $ic -o 60 = $ic -o 149 = $ic -o 157 = $ic ]; then
						SIDEBAND="l"
					elif [ 40 = $ic -o 48 = $ic -o 56 = $ic -o 64 = $ic -o 153 = $ic -o 161 = $ic ]; then
						SIDEBAND="u"
					else
						SIDEBAND=""
					fi	    	
				fi
				CHANSPEC="$CONF_CHANNEL$SIDEBAND"
			elif [ "80" = "$BANDWIDTH" ]; then	# 80MHz for 5G
				CHANSPEC="$CONF_CHANNEL/80"
			fi
			if [ "$CHANNEL_SIDEBAND" = "$CHANSPEC" ]; then
				eval channel_$VIR_IFNAME="1"
				if [ "40" = "$BANDWIDTH" ]; then
					if [ "wl0" = "$VIR_IFNAME" ]; then
						sysevent set coex_acsd 1
						echo "Need acsd to do coex check" > /dev/console
					fi
					if [ "l" = $SIDEBAND ]; then
						CHAN2="`expr $CONF_CHANNEL + 4`"
					else
						CHAN2="`expr $CONF_CHANNEL - 4`"
					fi
				else
					CHAN2=`wl -i $ifs status | grep -rin "Chanspec:" | awk -F" " '{print $5}'`
					if [ "$CHANSPEC" = "$CHAN2" ]; then
						CHAN2="0"
					fi
				fi
				sysevent set ${VIR_IFNAME}_secondary_channel "$CHAN2"
			elif [ "wl0" = "$VIR_IFNAME" ] && [ "40" = "$BANDWIDTH" ] && [ "$CHANNEL_SIDEBAND" = "$CONF_CHANNEL" ]; then
				sysevent set coex_acsd 0
				channel_wl0="1"
			else
				logger -p local7.notice -t WIFI "chanspec incorrect[$CHANNEL_SIDEBAND], try to fix[$CHANSPEC]" 
				wl -i $ifs down
				wl -i $ifs chanspec $CHANSPEC
				wl -i $ifs up
				if [ "a" = "`wl -i $ifs band`" ]; then
					wl -i $ifs pspretend_threshold 10
				fi
			fi
		fi
	done
	if [ "1" = "$channel_wl0" ] && [ "1" = "$channel_wl1" ]; then
		start_acsd
		/etc/init.d/service_wifi/get_wifi_runtime_info.sh &
		exit 0
	fi
	FIX_TRY="`expr $FIX_TRY + 1`"
	if [ "5" = "$FIX_TRY" ]; then
		start_acsd
		exit 0
	fi
	sleep 2
done

#!/bin/sh
source /etc/init.d/ulog_functions.sh
source /etc/init.d/service_wifi/wifi_utils.sh
SERVICE_NAME="wifi_monitor"
WIFI_DEBUG_SETTING=`syscfg get ${SERVICE_NAME}_debug`
DEBUG() 
for IF_NAME in $PHYSICAL_IF_LIST; do
	VENDOR_NAME=`syscfg get hardware_vendor_name`
	case "$VENDOR_NAME" in
		Broadcom)
			DRIVER_STATUS=`wl -i $IF_NAME isup`
			;;
		Marvell)
			IF_STATE=`ifconfig $IF_NAME | grep UP | awk '{print $1}'`
			if [ "$IF_STATE" = "UP" ]; then
				DRIVER_STATUS=1
			else
				DRIVER_STATUS=0
			fi
			;;
		MediaTek)
			IF_STATE=`ifconfig $IF_NAME | grep UP | awk '{print $1}'`
			if [ "$IF_STATE" = "UP" ]; then
				DRIVER_STATUS=1
			else
				DRIVER_STATUS=0
			fi
			;;
		Ralink)
			IF_STATE=`ifconfig $IF_NAME | grep UP | awk '{print $1}'`
			if [ "$IF_STATE" = "UP" ]; then
				DRIVER_STATUS=1
			else
				DRIVER_STATUS=0
			fi
			;;
		*)
			echo "wifi, error: unknow hardware vendor name"
			;;
	esac
			
	VIR_IFNAME=`get_syscfg_interface_name $IF_NAME`
	if [ "`sysevent get ${VIR_IFNAME}_status`" = "up" ] && [ "$DRIVER_STATUS" = "0" ]; then
		ulog ${SERVICE_NAME} status "${SERVICE_NAME}, ERROR: why $IF_NAME is currently down... wifi monitor brings it back up (`date`)"
		echo "${SERVICE_NAME}, ERROR: why $IF_NAME is currently down... wifi monitor brings it back up (`date`)"
		sysevent set wifi-restart
		break
	fi	
done
return 0

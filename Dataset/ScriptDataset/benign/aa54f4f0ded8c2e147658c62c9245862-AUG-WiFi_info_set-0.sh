#!/bin/sh
source /etc/init.d/ulog_functions.sh
source /etc/init.d/syscfg_api.sh
US_CH_LIST_2G="1,2,3,4,5,6,7,8,9,10,11"
US_CH_LIST_5G="36,40,44,48,149,153,157,161,165"
EU_CH_LIST_2G="1,2,3,4,5,6,7,8,9,10,11,12,13"
EU_CH_LIST_5G="36,40,44,48"
AP_CH_LIST_2G="1,2,3,4,5,6,7,8,9,10,11,12,13"
AP_CH_LIST_5G="36,40,44,48,149,153,157,161,165"
NEED_RESTORE=FALSE
SKU=`skuapi -g model_sku | awk -F"=" '{print $2}' | sed 's/ //g'`
PRODUCT=`echo $SKU | awk -F"-" '{print $1}'`
REGION_CODE=`skuapi -g cert_region | awk -F"=" '{print $2}' | sed 's/ //g'`
P_IF_INDEX_LIST=`syscfg_get lan_wl_physical_ifnames | wc -w`
for i in `seq 1 $P_IF_INDEX_LIST`
do
	WL_INDEX=wl`expr $i - 1`
        CH_LIST=`syscfg_get "$WL_INDEX"_available_channels`
	if [ -z "$CH_LIST" ]; then
		NEED_RESTORE=TRUE
		break
	fi
done
SYSCFG_REGION_CODE=`syscfg_get device::cert_region`
if [ -z "$REGION_CODE" ]; then
	if [ "$SYSCFG_REGION_CODE" != "US" ]; then
		NEED_RESTORE=TRUE
	fi
else
	if [ "$SYSCFG_REGION_CODE" != "$REGION_CODE" ]; then
		NEED_RESTORE=TRUE
	fi
fi
if [ "TRUE" = "$NEED_RESTORE" ]; then
	echo "SKU is $SKU" > /dev/console
	if [ -z "$REGION_CODE" ]; then
		REGION_CODE="US"
	fi
	wl0_available_channels=`syscfg_get wl0_available_channels`
	wl1_available_channels=`syscfg_get wl1_available_channels`
	case "$REGION_CODE" in
		"US")
			syscfg_set device::cert_region "US"
			syscfg_set device::model_base "$PRODUCT"
			
			if [ -z "$wl0_available_channels" ]; then
				syscfg_set wl0_available_channels "$US_CH_LIST_2G"
			fi
			if [ -z "$wl1_available_channels" ]; then
				syscfg_set wl1_available_channels "$US_CH_LIST_5G"
			fi
			syscfg_commit
			;;
		"EU")
			syscfg_set device::cert_region "EU"
			syscfg_set device::model_base "$PRODUCT"
			if [ -z "$wl0_available_channels" ]; then
				syscfg_set wl0_available_channels "$EU_CH_LIST_2G"
			fi
			if [ -z "$wl1_available_channels" ]; then
				syscfg_set wl1_available_channels "$EU_CH_LIST_5G"
			fi
			syscfg_commit
			;;
		"AU")
			syscfg_set device::cert_region "AU"
			syscfg_set device::model_base "$PRODUCT"
			if [ -z "$wl0_available_channels" ]; then
				syscfg_set wl0_available_channels "$AP_CH_LIST_2G"
			fi
			if [ -z "$wl1_available_channels" ]; then
				syscfg_set wl1_available_channels "$AP_CH_LIST_5G"
			fi
			syscfg_commit
			;;
		"CA")
			syscfg_set device::cert_region "CA"
			syscfg_set device::model_base "$PRODUCT"
			if [ -z "$wl0_available_channels" ]; then
				syscfg_set wl0_available_channels "$US_CH_LIST_2G"
			fi
			if [ -z "$wl1_available_channels" ]; then
				syscfg_set wl1_available_channels "$US_CH_LIST_5G"
			fi
			syscfg_commit
			;;
		"AP")
			syscfg_set device::cert_region "AP"
			syscfg_set device::model_base "$PRODUCT"
			if [ -z "$wl0_available_channels" ]; then
				syscfg_set wl0_available_channels "$AP_CH_LIST_2G"
			fi
			if [ -z "$wl1_available_channels" ]; then
				syscfg_set wl1_available_channels "$AP_CH_LIST_5G"
			fi
			syscfg_commit
			;;
		"PH")
			syscfg_set device::cert_region "PH"
			syscfg_set device::model_base "$PRODUCT"
			if [ -z "$wl0_available_channels" ]; then
				syscfg_set wl0_available_channels "$AP_CH_LIST_2G"
			fi
			if [ -z "$wl1_available_channels" ]; then
				syscfg_set wl1_available_channels "$AP_CH_LIST_5G"
			fi
			syscfg_commit
			;;
		*)
			ulog wlan status "wifi, Invalid region code, could not set on WiFi" > /dev/console
			;;
	esac
	ulog wlan status "wifi, Channel list and region code is set on syscfg" > /dev/console
else
	ulog wlan status "wifi, Channel list is available. Do nothing" > /dev/console
fi

#!/bin/sh
source /etc/init.d/service_wifi/wifi_utils.sh
source /etc/init.d/syscfg_api.sh
MODULE_PATH=/lib/modules/`uname -r`/
do_update_settings()
if [ ! -z "$CHECK_TOKEN" ]; then
	sysevent set wifi_system_boot_init 1
	DEVICE_TYPE=`syscfg get device::deviceType | awk -F":" '{print $4}'`
	echo "Device is Broadcom $DEVICE_TYPE" > /dev/console
fi
VALIDATED=`syscfg get wl_params_validated`
if [ "true" != "$VALIDATED" ]; then
	do_update_settings
	syscfg_set wl_params_validated true
fi

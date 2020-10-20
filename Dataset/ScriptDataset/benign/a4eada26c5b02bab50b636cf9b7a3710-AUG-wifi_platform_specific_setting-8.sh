	echo "${SERVICE_NAME}, loading Wi-Fi driver"
	MODULE_PATH=/lib/modules/`uname -r`/
	MODULE_NAME="mt_wifi.ko"
	
	if [ -f "${MODULE_PATH}${MODULE_NAME}" ]; then
		cd $MODULE_PATH
		insmod $MODULE_NAME
		return 0
	else
		ERROR="${SERVICE_NAME}, Error! Missing wifi modules in $MODULE_PATH"
		ulog wlan status $ERROR > /dev/console
		return 1
	fi

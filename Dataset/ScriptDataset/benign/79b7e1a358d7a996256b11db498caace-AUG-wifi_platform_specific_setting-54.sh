	ONE_TIME=`sysevent get virtual-one-time-setting`
	if [ "$ONE_TIME" != "TRUE" ] ; then
		echo "wifi, platform_virtual_onetime_setting()"
		ulog wlan status "wifi, platform_virtual_onetime_setting()"
		sysevent set virtual-one-time-setting "TRUE"
	fi

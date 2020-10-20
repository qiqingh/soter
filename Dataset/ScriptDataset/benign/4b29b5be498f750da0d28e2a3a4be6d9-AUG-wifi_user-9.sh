	UUID=`syscfg_get device::uuid`
	uuid="uuid=$UUID"
	upnp="upnp_iface=br0"
	AP_PIN=`syscfg_get device::wps_pin`
	SN=`syscfg_get device::serial_number`
	MODEL_BASE=`syscfg_get device::model_base`
        MODEL_DESC=`syscfg_get device::modelDescription`
        MANUFACTOURER=`syscfg_get device::manufacturer`
	REAL_DEVICE_NAME=`syscfg_get hostname`
	DEVICE_NAME_LEN=`echo "$REAL_DEVICE_NAME" | wc -c`
	if [ `expr $DEVICE_NAME_LEN` -gt 32 ]; then
		QN_DEVICE_NAME=`echo "$REAL_DEVICE_NAME" | cut -c1-32`
	else
		QN_DEVICE_NAME="$REAL_DEVICE_NAME"
	fi
	cat <<EOF
wps_state=$WPS_STATE
ap_setup_locked=0
wps_pin_requests=/var/run/hostapd_wps_pin_requests
device_name=$QN_DEVICE_NAME
manufacturer=$MANUFACTOURER
$uuid
model_name=$MODEL_BASE
model_number=$MODEL_BASE
device_type=6-0050F204-1
serial_number=$SN
config_methods=label display push_button virtual_display virtual_push_button physical_push_button
ap_pin=$AP_PIN
$upnp
friendly_name=$REAL_DEVICE_NAME
model_description=$MODEL_DESC
EOF

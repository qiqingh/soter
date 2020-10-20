	local driver usb devicename desc

	for a in `ls /sys/bus/usb/devices`; do
		local vendor product
		[ -z "$usb" -a -f /sys/bus/usb/devices/$a/idVendor -a -f /sys/bus/usb/devices/$a/idProduct ] || continue
		vendor=$(cat /sys/bus/usb/devices/$a/idVendor)
		product=$(cat /sys/bus/usb/devices/$a/idProduct)
		[ -f /lib/network/wwan/$vendor:$product ] && {
			usb=/lib/network/wwan/$vendor:$product
			devicename=$a
		}
	done

	[ -n "$usb" ] && {
		local old_cb control data

		json_set_namespace wwan old_cb
		json_init
		json_load "$(cat $usb)"
		json_select
		json_get_vars desc control data
		json_set_namespace $old_cb

		[ -n "$control" -a -n "$data" ] && {
			ttys=$(ls -d /sys/bus/usb/devices/$devicename/${devicename}*/tty?* /sys/bus/usb/devices/$devicename/${devicename}*/tty/tty?* | sed "s/.*\///g" | tr "\n" " ")
			ctl_device=/dev/$(echo $ttys | cut -d" " -f $((control + 1)))
			dat_device=/dev/$(echo $ttys | cut -d" " -f $((data + 1)))
			driver=comgt
		}
	}

	[ -z "$ctl_device" ] && for net in $(ls /sys/class/net/ | grep -e wwan -e usb); do
		[ -z "$ctl_device" ] || continue
		driver=$(grep DRIVER /sys/class/net/$net/device/uevent | cut -d= -f2)
		case "$driver" in
		qmi_wwan|cdc_mbim)
			ctl_device=/dev/$(ls /sys/class/net/$net/device/usbmisc)
			;;
		sierra_net|cdc_ether|*cdc_ncm)
			ctl_device=/dev/$(cd /sys/class/net/$net/; find ../../../ -name ttyUSB* |xargs -n1 basename | head -n1)
			;;
		*) continue;;
		esac
		echo "wwan[$$]" "Using proto:$proto device:$ctl_device iface:$net desc:$desc"
	done

	[ -n "$ctl_device" ] || {
		echo "wwan[$$]" "No valid device was found"
		proto_notify_error "$interface" NO_DEVICE
		proto_block_restart "$interface"
		return 1
	}

	uci_set_state network $interface driver "$driver"
	uci_set_state network $interface ctl_device "$ctl_device"
	uci_set_state network $interface dat_device "$dat_device"

	case $driver in
	qmi_wwan)		proto_qmi_setup $@ ;;
	cdc_mbim)		proto_mbim_setup $@ ;;
	sierra_net)		proto_directip_setup $@ ;;
	comgt)			proto_3g_setup $@ ;;
	cdc_ether|*cdc_ncm)	proto_ncm_setup $@ ;;
	esac

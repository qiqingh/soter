	local vif="$1" && shift
	local driver="$1" && shift
	local no_nconfig
	local ifname device channel hwmode

	hostapd_cfg=

	# These are flags that may or may not be used when calling
	# "hostapd_setup_vif()". These are not mandatory and may be called in
	# any order
	while [ $# -ne 0 ]; do
		local tmparg="$1" && shift
		case "$tmparg" in
		no_nconfig)
			no_nconfig=1
			;;
		esac
	done

	config_get ifname "$vif" ifname
	config_get device "$vif" device
	config_get channel "$device" channel
	config_get hwmode "$device" hwmode

	hostapd_set_log_options hostapd_cfg "$device"
	hostapd_set_bss_options hostapd_cfg "$vif"

	case "$hwmode" in
		*bg|*gdt|*gst|*fh) hwmode=g;;
		*adt|*ast) hwmode=a;;
	esac
	[ "$channel" = auto ] && channel=
	[ -n "$channel" -a -z "$hwmode" ] && wifi_fixup_hwmode "$device"
	cat > /var/run/hostapd-$ifname.conf <<EOF
driver=$driver
interface=$ifname
${channel:+channel=$channel}
$hostapd_cfg
EOF
	[ -z "${no_nconfig}" ] &&
		echo ${hwmode:+hw_mode=${hwmode#11}} >> /var/run/hostapd-$ifname.conf

	# Run a single hostapd instance for all the radio's
	# Enables WPS VAP TIE feature
	config_get_bool wps_vap_tie_dbdc qcawifi wps_vap_tie_dbdc 0

	if [ $wps_vap_tie_dbdc -ne 0 ]; then
		echo -e "/var/run/hostapd-$ifname.conf \c\h" >> /tmp/hostapd_conf_filename
	else
		hostapd -P /var/run/wifi-$ifname.pid -B /var/run/hostapd-$ifname.conf

		if [ -n "$wps_possible" -a -n "$config_methods" ]; then
			pid=/var/run/hostapd_cli-$ifname.pid
			hostapd_cli -i $ifname -P $pid -a /lib/wifi/wps-hostapd-update-uci -p /var/run/hostapd-$device -B
		fi
	fi


	local device="$1"
	set_wifi_down "$device"
	(
		include /lib/network

		local pid_file=/var/run/nas.$device.pid
		[ -e $pid_file ] && start-stop-daemon -K -q -s SIGKILL -p $pid_file && rm $pid_file

		# make sure the interfaces are down and removed from all bridges
		local dev ifname
		for dev in /sys/class/net/wds${device##wl}-* /sys/class/net/${device}-* /sys/class/net/${device}; do
			if [ -e "$dev" ]; then
				ifname=${dev##/sys/class/net/}
				ip link set dev "$ifname" down
				unbridge "$ifname"
			fi
		done

		# make sure all of the devices are disabled in the driver
		local ifdown=
		local bssmax=$(wlc ifname "$device" bssmax)
		local vif=$((${bssmax:-4} - 1))
		append ifdown "down" "$N"
		append ifdown "wds none" "$N"
		while [ $vif -ge 0 ]; do
			append ifdown "vif $vif" "$N"
			append ifdown "enabled 0" "$N"
			vif=$(($vif - 1))
		done

		wlc ifname "$device" stdin <<EOF
$ifdown
leddc 0xffff
EOF
	)
	true

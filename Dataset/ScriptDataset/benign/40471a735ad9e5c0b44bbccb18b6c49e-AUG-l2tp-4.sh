	local interface="$1"
	local optfile="/tmp/l2tp/options.${interface}"

	rm -f ${optfile}
	if [ -p /var/run/xl2tpd/l2tp-control ]; then
		xl2tpd-control remove l2tp-${interface} || {
			echo "xl2tpd-control: Remove l2tp-$interface failed" >&2
		}
	fi
	# Wait for interface to go down
        while [ -d /sys/class/net/l2tp-${interface} ]; do
		sleep 1
	done

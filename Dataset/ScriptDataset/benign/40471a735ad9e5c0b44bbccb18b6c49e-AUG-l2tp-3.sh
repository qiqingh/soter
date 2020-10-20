	local interface="$1"
	local optfile="/tmp/l2tp/options.${interface}"
	local ip serv_addr server host

	json_get_var server server
	host="${server%:*}"
	for ip in $(resolveip -t 5 "$host"); do
		( proto_add_host_dependency "$interface" "$ip" )
		serv_addr=1
	done
	[ -n "$serv_addr" ] || {
		echo "Could not resolve server address" >&2
		sleep 5
		proto_setup_failed "$interface"
		exit 1
	}

	# Start and wait for xl2tpd
	if [ ! -p /var/run/xl2tpd/l2tp-control -o -z "$(pidof xl2tpd)" ]; then
		/etc/init.d/xl2tpd restart

		local wait_timeout=0
		while [ ! -p /var/run/xl2tpd/l2tp-control ]; do
			wait_timeout=$(($wait_timeout + 1))
			[ "$wait_timeout" -gt 5 ] && {
				echo "Cannot find xl2tpd control file." >&2
				proto_setup_failed "$interface"
				exit 1
			}
			sleep 1
		done
	fi

	local ipv6 demand keepalive username password pppd_options mtu
	json_get_vars ipv6 demand keepalive username password pppd_options mtu
	[ "$ipv6" = 1 ] || ipv6=""
	if [ "${demand:-0}" -gt 0 ]; then
		demand="precompiled-active-filter /etc/ppp/filter demand idle $demand"
	else
		demand="persist"
	fi

	local interval="${keepalive##*[, ]}"
	[ "$interval" != "$keepalive" ] || interval=5

	keepalive="${keepalive:+lcp-echo-interval $interval lcp-echo-failure ${keepalive%%[, ]*}}"
	username="${username:+user \"$username\" password \"$password\"}"
	ipv6="${ipv6:++ipv6}"
	mtu="${mtu:+mtu $mtu mru $mtu}"

	mkdir -p /tmp/l2tp
	cat <<EOF >"$optfile"
usepeerdns
nodefaultroute
ipparam "$interface"
ifname "l2tp-$interface"
ip-up-script /lib/netifd/ppp-up
ipv6-up-script /lib/netifd/ppp-up
ip-down-script /lib/netifd/ppp-down
ipv6-down-script /lib/netifd/ppp-down
# Don't wait for LCP term responses; exit immediately when killed.
lcp-max-terminate 0
$keepalive
$username
$ipv6
$mtu
$pppd_options
EOF

	xl2tpd-control add l2tp-${interface} pppoptfile=${optfile} lns=${server} || {
		echo "xl2tpd-control: Add l2tp-$interface failed" >&2
		proto_setup_failed "$interface"
		exit 1
	}
	xl2tpd-control connect l2tp-${interface} || {
		echo "xl2tpd-control: Connect l2tp-$interface failed" >&2
		proto_setup_failed "$interface"
		exit 1
	}

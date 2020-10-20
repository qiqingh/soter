	local cfg="$1"
	local iface="$2"
	local link="6rd-$cfg"

	local mtu df ttl tos ipaddr peeraddr ip6prefix ip6prefixlen ip4prefixlen tunlink zone
	json_get_vars mtu df ttl tos ipaddr peeraddr ip6prefix ip6prefixlen ip4prefixlen tunlink zone

	[ -z "$ip6prefix" -o -z "$peeraddr" ] && {
		proto_notify_error "$cfg" "MISSING_ADDRESS"
		proto_block_restart "$cfg"
		return
	}

	( proto_add_host_dependency "$cfg" "$peeraddr" "$tunlink" )

	[ -z "$ipaddr" ] && {
		local wanif="$tunlink"
		if [ -z $wanif ] && ! network_find_wan wanif; then
			proto_notify_error "$cfg" "NO_WAN_LINK"
			return
		fi

		if ! network_get_ipaddr ipaddr "$wanif"; then
			proto_notify_error "$cfg" "NO_WAN_LINK"
			return
		fi
	}

	# Determine the relay prefix.
	local ip4prefixlen="${ip4prefixlen:-0}"
	local ip4prefix=$(ipcalc.sh "$ipaddr/$ip4prefixlen" | grep NETWORK)
	ip4prefix="${ip4prefix#NETWORK=}"

	# Determine our IPv6 address.
	local ip6subnet=$(6rdcalc "$ip6prefix/$ip6prefixlen" "$ipaddr/$ip4prefixlen")
	local ip6suffix="$(calc_ip6suffix $(cat /sys/class/net/eth1/address))"
	local ip6addr="${ip6subnet%%::*}:$ip6suffix"

	# Determine the IPv6 prefix
	local ip6lanprefix="$ip6subnet/$(($ip6prefixlen + 32 - $ip4prefixlen))"

	proto_init_update "$link" 1
	proto_add_ipv6_address "$ip6addr" "$ip6prefixlen"
	proto_add_ipv6_prefix "$ip6lanprefix"

	proto_add_ipv6_route "::" 0 "::$peeraddr" 4096 "" "$ip6addr/$ip6prefixlen"
	proto_add_ipv6_route "::" 0 "::$peeraddr" 4096 "" "$ip6lanprefix"

	proto_add_tunnel
	json_add_string mode sit
	json_add_int mtu "${mtu:-1280}"
	json_add_boolean df "${df:-1}"
	json_add_int ttl "${ttl:-64}"
	[ -n "$tos" ] && json_add_string tos "$tos"
	json_add_string local "$ipaddr"
	json_add_string 6rd-prefix "$ip6prefix/$ip6prefixlen"
	json_add_string 6rd-relay-prefix "$ip4prefix/$ip4prefixlen"
	[ -n "$tunlink" ] && json_add_string link "$tunlink"
	proto_close_tunnel

	proto_add_data
	[ -n "$zone" ] && json_add_string zone "$zone"
	proto_close_data

	proto_send_update "$cfg"

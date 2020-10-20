	local cfg="$1"
	local iface="$2"
	local link="ds-$cfg"
	local remoteip6

	local mtu ttl peeraddr ip6addr tunlink zone weakif
	json_get_vars mtu ttl peeraddr ip6addr tunlink zone weakif

	[ -z "$peeraddr" ] && {
		proto_notify_error "$cfg" "MISSING_ADDRESS"
		proto_block_restart "$cfg"
		return
	}

	( proto_add_host_dependency "$cfg" "::" "$tunlink" )

	remoteip6=$(resolveip -6 $peeraddr)
	if [ -z "$remoteip6" ]; then
		sleep 3
		remoteip6=$(resolveip -6 $peeraddr)
		if [ -z "$remoteip6" ]; then
			proto_notify_error "$cfg" "AFTR_DNS_FAIL"
			return
		fi
	fi
	peeraddr="${remoteip6%% *}"

	[ -z "$ip6addr" ] && {
		local wanif="$tunlink"
		if [ -z "$wanif" ] && ! network_find_wan6 wanif; then
			proto_notify_error "$cfg" "NO_WAN_LINK"
			return
		fi

		if ! network_get_ipaddr6 ip6addr "$wanif"; then
			[ -z "$weakif" ] && weakif="lan"
			if ! network_get_ipaddr6 ip6addr "$weakif"; then
				proto_notify_error "$cfg" "NO_WAN_LINK"
				return
			fi
		fi
	}

	proto_init_update "$link" 1
	proto_add_ipv4_route "0.0.0.0" 0
	proto_add_ipv4_address "192.0.0.2" "" "" "192.0.0.1"

	proto_add_tunnel
	json_add_string mode ipip6
	json_add_int mtu "${mtu:-1280}"
	json_add_int ttl "${ttl:-64}"
	json_add_string local "$ip6addr"
	json_add_string remote "$peeraddr"
	[ -n "$tunlink" ] && json_add_string link "$tunlink"
	proto_close_tunnel

	proto_add_data
	[ -n "$zone" ] && json_add_string zone "$zone"

	json_add_array firewall
	  json_add_object ""
	    json_add_string type nat
	    json_add_string target ACCEPT
	  json_close_object
	json_close_array
	proto_close_data

	proto_send_update "$cfg"

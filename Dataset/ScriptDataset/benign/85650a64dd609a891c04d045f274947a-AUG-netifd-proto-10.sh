	local ifname="$1"
	local up="$2"
	local external="$3"

	PROTO_KEEP=0
	PROTO_INIT=1
	PROTO_TUNNEL_OPEN=
	PROTO_IPADDR=
	PROTO_IP6ADDR=
	PROTO_ROUTE=
	PROTO_ROUTE6=
	PROTO_PREFIX6=
	PROTO_DNS=
	PROTO_DNS_SEARCH=
	json_init
	json_add_int action 0
	[ -n "$ifname" -a "*" != "$ifname" ] && json_add_string "ifname" "$ifname"
	json_add_boolean "link-up" "$up"
	[ -n "$3" ] && json_add_boolean "address-external" "$external"

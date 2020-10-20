	local interface="$1"

	proto_close_nested
	json_add_boolean keep "$PROTO_KEEP"
	_proto_push_array "ipaddr" "$PROTO_IPADDR" _proto_push_ipv4_addr
	_proto_push_array "ip6addr" "$PROTO_IP6ADDR" _proto_push_ipv6_addr
	_proto_push_array "routes" "$PROTO_ROUTE" _proto_push_route
	_proto_push_array "routes6" "$PROTO_ROUTE6" _proto_push_route
	_proto_push_array "ip6prefix" "$PROTO_PREFIX6" _proto_push_string
	_proto_push_array "dns" "$PROTO_DNS" _proto_push_string
	_proto_push_array "dns_search" "$PROTO_DNS_SEARCH" _proto_push_string
	_proto_notify "$interface"

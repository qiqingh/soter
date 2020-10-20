	local address="$1"
	local mask="$2"
	local broadcast="$3"
	local ptp="$4"

	append PROTO_IPADDR "$address/$mask/$broadcast/$ptp"

	local target="$1"
	local mask="$2"
	local gw="$3"
	local metric="$4"
	local valid="$5"
	local source="$6"
	local table="$7"

	append PROTO_ROUTE6 "$target/$mask/$gw/$metric/$valid/$table/$source"

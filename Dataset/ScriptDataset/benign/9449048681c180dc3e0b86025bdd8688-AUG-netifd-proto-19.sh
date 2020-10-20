	local target="$1"
	local mask="$2"
	local gw="$3"
	local source="$4"
	local metric="$5"

	append PROTO_ROUTE "$target/$mask/$gw/$metric///$source"

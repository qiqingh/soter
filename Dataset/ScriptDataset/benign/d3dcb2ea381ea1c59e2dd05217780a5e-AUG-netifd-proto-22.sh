	local address="$1"
	local mac="$2"
	local proxy="$3"

	append PROTO_NEIGHBOR "$address/$mac/$proxy"

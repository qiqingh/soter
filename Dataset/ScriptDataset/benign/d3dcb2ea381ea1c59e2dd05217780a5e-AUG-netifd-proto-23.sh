	local address="$1"
	local mac="$2"
	local proxy="$3"
	local router="$4"

	append PROTO_NEIGHBOR6 "$address/$mac/$proxy/$router"

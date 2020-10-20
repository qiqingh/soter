	local address="$1"
	local mask="$2"
	local preferred="$3"
	local valid="$4"
	local offlink="$5"
	local class="$6"

	append PROTO_IP6ADDR "$address/$mask/$preferred/$valid/$offlink/$class"

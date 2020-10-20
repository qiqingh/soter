	local __DATA=""
	config_cb()
	{
		[ "$1" = "service" ] && __DATA="$__DATA $2"
	}
	config_load "ddns"
	eval "$1=\"$__DATA\""
	return

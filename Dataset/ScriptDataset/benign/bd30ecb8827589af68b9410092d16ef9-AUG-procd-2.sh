	local old_cb

	json_set_namespace procd old_cb
	"$@"
	json_set_namespace $old_cb

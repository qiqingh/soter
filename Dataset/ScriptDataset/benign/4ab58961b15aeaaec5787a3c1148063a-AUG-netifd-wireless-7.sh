	local old_cb

	json_set_namespace wdev old_cb
	"$@"
	json_set_namespace $old_cb

	local old_ns

	json_set_namespace "k2t" old_ns

	if k2t_config_load; then
		json_select "this_dev_info"
		json_get_var val "$1"
		json_select ..
	fi

	json_set_namespace old_ns

	echo $val

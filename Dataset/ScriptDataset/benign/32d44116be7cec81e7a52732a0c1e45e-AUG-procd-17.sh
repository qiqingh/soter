	local _json_no_warning=1

	json_select "jail"
	[ $? = 0 ] || return
	json_select "mount"
	[ $? = 0 ] || {
		json_select ..
		return
	}
	for a in $@; do
		json_add_string "$a" "1"
	done
	json_select ..
	json_select ..

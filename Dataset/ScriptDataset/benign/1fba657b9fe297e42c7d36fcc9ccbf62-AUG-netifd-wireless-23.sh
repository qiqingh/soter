	local _w_stas _w_sta

	json_get_keys _w_stas stas
	json_select stas
	for _w_sta in $_w_stas; do
		json_select "$_w_sta"
		json_select config
		"$@" "$_w_sta"
		json_select ..
		json_select ..
	done
	json_select ..
